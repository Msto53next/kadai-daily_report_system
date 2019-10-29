<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <h2>新規タスク追加</h2>

        <form method="POST" action="<c:url value='/tasks/create' />">
            <c:import url="_form.jsp" />
        </form>

        <label for="status">状態</label>
        <select name="status">
            <option value="0" <c:if test="${task.status == 0}"> selected</c:if>>未着手</option>
            <option disabled value="1" <c:if test="${task.status == 1}"> selected</c:if>>作業中！</option>
            <option disabled value="2" <c:if test="${task.status == 2}"> selected</c:if>>達成！</option>
            <option disabled value="3" <c:if test="${task.status == 3}"> selected</c:if>>期限超過…</option>
        </select>
        <br /><br />

        <input type="hidden" name="_token" value="${_token}" />
        <button type="submit">投稿</button>

        <p><a href="<c:url value='/tasks/index' />">タスク一覧に戻る</a></p>
    </c:param>
</c:import>