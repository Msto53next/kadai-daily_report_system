package controllers.toppage;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Employee;
import models.Report;
import models.Task;
import utils.DBUtil;

/**
 * Servlet implementation class TopPageIndexServlet
 */
@WebServlet("/index.html")
public class TopPageIndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public TopPageIndexServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = DBUtil.createEntityManager();

        Employee login_employee = (Employee)request.getSession().getAttribute("login_employee");

        int page;
        try{
            page = Integer.parseInt(request.getParameter("page"));
        } catch(Exception e) {
            page = 1;
        }

        List<Report> reports = em.createNamedQuery("getMyAllReports", Report.class)
                                 .setParameter("employee", login_employee)
                                 .setFirstResult(15 * (page - 1))
                                 .setMaxResults(15)
                                 .getResultList();

        long reports_count = (long)em.createNamedQuery("getMyReportsCount", Long.class)
                                      .setParameter("employee", login_employee)
                                      .getSingleResult();

        //タスク用ページネーション
        int pageT;
        try{
            pageT = Integer.parseInt(request.getParameter("pageT"));
        } catch(Exception e) {
            pageT = 1;
        }

        List<Task> tasks = em.createNamedQuery("getMyAllTasks", Task.class)
                              .setParameter("employee", login_employee)
                              .setFirstResult(15 * (pageT -1))
                              .setMaxResults(15)
                              .getResultList();

        long tasks_count = (long)em.createNamedQuery("getMyTasksCount", Long.class)
                                      .setParameter("employee", login_employee)
                                      .getSingleResult();

        //タスク達成率の計算用に、getMyCompletedTasksCountを実行
        long compTasks_count = (long)em.createNamedQuery("getMyCompletedTasksCount", Long.class)
                                           .setParameter("employee", login_employee)
                                           .getSingleResult();

        //達成率は（達成した数÷タスクの総数）のごく簡単な形で求める。
        Double achivement = (double)(compTasks_count / (double)tasks_count * 1.0) * 100;

        //achivementをString.formatで小数点第二位まで指定して文字列型の変数に格納。

        String achive = String.format("%.2f", achivement);

        em.close();

        request.setAttribute("reports", reports);
        request.setAttribute("reports_count", reports_count);
        request.setAttribute("page", page);

        request.setAttribute("tasks", tasks);
        request.setAttribute("tasks_count", tasks_count);
        request.setAttribute("achive", achive);
        request.setAttribute("pageT", pageT);

        if(request.getSession().getAttribute("flush") != null) {
            request.setAttribute("flush", request.getSession().getAttribute("flush"));
            request.getSession().removeAttribute("flush");
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/topPage/index.jsp");
        rd.forward(request, response);
    }

}
