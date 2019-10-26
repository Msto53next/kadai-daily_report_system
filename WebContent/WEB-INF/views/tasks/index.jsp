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
                            <c:when test="${task_status == 0}">未着手</c:when>
                            <c:when test="${task_status == 1}">作業中！</c:when>
                            <c:when test="${task_status == 2}">達成！</c:when>
                            <c:otherwise>期限超過…</c:otherwise>
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