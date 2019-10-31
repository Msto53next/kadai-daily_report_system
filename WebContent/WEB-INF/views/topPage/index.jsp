<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="../layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>
        <h2>日報管理システムへようこそ</h2>
        <div class="describe">
            <p>現在の状況 : </p><br />
            <div class="tips">
                <c:out value="${sessionScope.login_employee.name}" />&nbsp;さんのタスク達成率<br />
                <p><c:out value="${achive}" />%</p>
            </div>
        </div>

        <details>
        <summary>【自分の日報 一覧】</summary>
        <table id="report_list">
            <tbody>
                <tr>
                    <th class="report_name">氏名</th>
                    <th class="report_date">日付</th>
                    <th class="report_title">タイトル</th>
                    <th class="report_action">操作</th>
                </tr>
                <c:forEach var="report" items="${reports}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="report_name"><c:out value="${report.employee.name}" /></td>
                        <td class="report_date"><fmt:formatDate value='${report.report_date}' pattern='yyyy-MM-dd' /></td>
                        <td class="report_title">${report.title}</td>
                        <td class="report_action"><a href="<c:url value='/reports/show?id=${report.id}' />">詳細を見る</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            (全 ${reports_count} 件) <br />
            <c:forEach var="i" begin="1" end="${((reports_count - 1) / 15) + 1}" step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p><a href="<c:url value='/reports/new' />">新規日報の登録</a></p>
        </details>

        <details>
        <summary>【自分のタスク 一覧】</summary>
        <table id="task_list">
            <tbody>
                <tr>
                    <th class="task_name">氏名</th>
                    <th class="task_date">日付</th>
                    <th class="task_title">タイトル</th>
                    <th class="task_action">タスク詳細</th>
                    <th class="task_status">状況</th>
                </tr>
                <c:forEach var="task" items="${tasks}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="task_name"><c:out value="${task.employee.name}" /></td>
                        <td class="task_date"><fmt:formatDate value='${task.task_date}' pattern='yyyy-MM-dd' /></td>
                        <td class="task_title">${task.title}</td>
                        <td class="task_action"><a href="<c:url value='/tasks/show?id=${task.id}' />">詳細を見る</a></td>
                        <td class="task_status">
                            <c:choose>
                                <c:when test="${task.status == 0}"><p class="no_touch">未着手</p></c:when>
                                <c:when test="${task.status == 1}"><p class="wip">作業中！</p></c:when>
                                <c:when test="${task.status == 2}"><p class="complete">達成！</p></c:when>
                                <c:otherwise><p class="overdue">期限超過…</p></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            (全 ${tasks_count} 件) <br />
            <c:forEach var="i" begin="1" end="${((tasks_count - 1) / 15) + 1}" step="1">
                <c:choose>
                    <c:when test="${i == pageT}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/?pageT=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p><a href="<c:url value='/tasks/new' />">新規タスク追加</a></p>
        </details>
    </c:param>
</c:import>