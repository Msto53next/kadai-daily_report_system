<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>
        <h2>タスク一覧</h2>
        <table id="task_list">
            <tbody>
                <tr>
                    <th class="task_name">担当者名</th>
                    <th class="task_date">タスク追加日</th>
                    <th class="task_title">タイトル</th>
                    <th class="task_action">タスク詳細</th>
                    <th class="task_status">状態</th>
                </tr>
                <c:forEach var="task" items="${tasks}" varStatus="status">
                    <tr>
                        <td class="task_name"><c:out value="${task.employee.name}"></c:out></td>
                        <td class="task_date"><fmt:formatDate value='${task.task_date}' pattern='yyyy-MM-dd' /></td>
                        <td class="task_title">${task.title}</td>
                        <td class="task_action"><a href="<c:url value='/tasks/show?id=${task.id}' />">内容を見る</a></td>
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
            (全 ${tasks_count} 件)<br />
            <c:forEach var="i" begin="1" end="${((tasks_count - 1) / 15) + 1}" step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/tasks/index?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p><a href="<c:url value='/tasks/new' />">タスクの追加</a></p>
    </c:param>
</c:import>