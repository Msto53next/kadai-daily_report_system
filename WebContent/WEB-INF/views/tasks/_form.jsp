<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${errors != null}">
    <div id="flush_error">
        入力内容にエラーがあります。<br />
        <c:forEach var="error" items="${errors}">
            ・<c:out value="${error}" /><br />
        </c:forEach>

    </div>
</c:if>
<label for="task_date">日付</label><br />
<input type="date" name="task_date" value="<fmt:formatDate value='${task.task_date}' pattern='yyyy-MM-dd' />" />
<br /><br />

<label for="name">氏名</label><br />
<c:out value="${sessionScope.login_employee.name}" />
<br /><br />

<label for="title">タイトル</label><br />
<input type="text" name="title" value="${task.title}" />
<br /><br />

<label for="content">タスク詳細</label><br />
<textarea name="content" rows="10" cols="50">${task.content}</textarea>
<br /><br />

<label for="status">状態</label>
<select name="status">
    <option value="0" <c:if test="${task.status == 0}"> selected</c:if>>未着手</option>
    <option value="1" <c:if test="${task.status == 1}"> selected</c:if>>作業中！</option>
    <option value="2" <c:if test="${task.status == 2}"> selected</c:if>>達成！</option>
    <option value="3" <c:if test="${task.status == 3}"> selected</c:if>>期限超過…</option>
</select>
<br /><br />

<input type="hidden" name="_token" value="${_token}" />
<button type="submit">投稿</button>
