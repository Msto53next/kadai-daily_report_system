<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:choose>
            <c:when test="${task != null}">
                <h2>タスク詳細</h2>

                <table>
                    <tbody>
                        <tr>
                            <th>担当者</th>
                            <td><c:out value="${task.employee.name}" /></td>
                        </tr>
                        <tr>
                            <th>日付</th>
                            <td><fmt:formatDate value='${task.task_date}' pattern='yyyy-MM-dd' /></td>
                        </tr>
                        <tr>
                            <th>作業内容</th>
                            <td>
                                <pre><c:out value="${task.content}" /></pre>
                            </td>
                        </tr>
                        <tr>
                            <th>登録日時</th>
                            <td>
                                <fmt:formatDate value='${task.created_at}' pattern='yyyy-MM-dd HH:mm:ss' />
                            </td>
                        </tr>
                        <tr>
                            <th>更新日時</th>
                            <td>
                                <fmt:formatDate value='${task.updated_at}' pattern='yyyy-MM-dd HH:mm:ss' />
                            </td>
                        </tr>
                         <tr>
                            <th>状態</th>
                            <td>
                                <c:choose>
                                    <c:when test="${task.status == 0}"><p class="no_touch">未着手</p></c:when>
                                    <c:when test="${task.status == 1}"><p class="wip">作業中！</p></c:when>
                                    <c:when test="${task.status == 2}"><p class="complete">達成！</p></c:when>
                                    <c:otherwise><p class="overdue">期限超過…</p></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <c:if test="${sessionScope.login_employee.id == task.employee.id}">
                    <p><a href="<c:url value='/tasks/edit?id=${task.id}' />">この日報を編集する</a></p>
                </c:if>
            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>

        <p><a href="<c:url value='/tasks/index' />">一覧に戻る</a></p>
    </c:param>
</c:import>