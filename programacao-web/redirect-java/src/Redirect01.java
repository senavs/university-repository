import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/redirect01")
public class Redirect01 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Redirect01() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String from = request.getParameter("from");
		if (from == null) {
			from = "";
		}
		
		if (from.equals("original")) {
			response.getWriter().append("você acessou /original e foi enviado para /redirect01");
		} else {
			response.getWriter().append("você acessou /redirect01 direto");
		}
	}

}
