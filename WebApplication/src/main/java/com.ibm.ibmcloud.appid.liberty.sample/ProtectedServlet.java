package com.ibm.ibmcloud.appid.liberty.sample;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Hashtable;
import java.util.Set;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.codec.binary.Base64;
import sun.misc.BASE64Decoder;
import io.jsonwebtoken.Claims;

import javax.annotation.security.DeclareRoles;
import javax.json.JsonObject;
import javax.security.auth.Subject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.HttpConstraint;
import javax.servlet.annotation.ServletSecurity;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ibm.json.java.JSONObject;
import com.ibm.websphere.security.WSSecurityException;
import com.ibm.websphere.security.auth.WSSubject;

/**
 * Servlet implementation class ProtectedServlet
 */

public class ProtectedServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        try {
            String idTokenRaw = getIDToken();
            if (idTokenRaw != null) {
                String idTokenPayload = getTokenPayload(idTokenRaw);
                // save the id_token and user's name on the request so that
                // they can be passed on to UI elements
                JSONObject idTokenContent = JSONObject.parse(idTokenPayload);
                String username = idTokenContent.get("name").toString();
                request.setAttribute("name", username);
                request.setAttribute("id_token", idTokenPayload);
            } else {
                out.println("No id_token located via security context");
            }
        } catch (Exception e) {
            // In real applications, exception should be handled better
            e.printStackTrace(out);
        }
        request.getRequestDispatcher("/protected.jsp").forward(request, response);
    }

    private String getTokenPayload(String token) {
        String payload64 = token.split("\\.")[1];
        String payload = new String(Base64.decodeBase64(payload64));
        return payload;
    }

    /*
    This method uses Liberty API to extract a Hashtable object that contains
    the App ID tokens.
     */
    private String getIDToken() throws IOException{
        Subject wasSubj;
        try {
            wasSubj = WSSubject.getRunAsSubject();
        } catch (WSSecurityException e) {
            // In real applications, exception should be handled better
            throw new IOException(e);
        }

        Set<Hashtable> creds = wasSubj.getPrivateCredentials(Hashtable.class);

        for (Hashtable hTable : creds) {
            if (hTable.containsKey("id_token")) {
                return hTable.get("id_token").toString();
            }
        }
        //return null if not found
        return null;
    }

}
