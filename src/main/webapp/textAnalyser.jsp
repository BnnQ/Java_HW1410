<%--@elvariable id="text" type="java.lang.String"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Text analyser</title>
    <%@include file="imports.jsp" %>
</head>
<body class="container">
<form action="text-analyser" method="post" class="d-flex flex-column">
    <label class="fs-3 mb-3" for="text">Text:</label>
    <textarea class="form-control mb-3" id="text" name="text" rows="10" cols="50">${not empty text ? text : ""}</textarea>
    <button class="btn btn-success mb-3" type="submit">Analyse</button>
</form>

<%--@elvariable id="listOfVowels" type="java.lang.Character[]"--%>
<%--@elvariable id="listOfConsonants" type="java.lang.Character[]"--%>
<%--@elvariable id="listOfPunctuationMarks" type="java.lang.Character[]"--%>
<c:if test="${not empty listOfVowels and not empty listOfConsonants and not empty listOfPunctuationMarks}">
    <div class="container">
        <div class="row">
            <div class="col-4">
                <h3>Vowels: <%= ((Character[]) request.getAttribute("listOfVowels")).length%></h3>
                <ul>
                    <c:forEach items="${listOfVowels}" var="vowel">
                        <li>${vowel}</li>
                    </c:forEach>
                </ul>
            </div>
            <div class="col-4">
                <h3>Consonants: <%= ((Character[]) request.getAttribute("listOfConsonants")).length%></h3>
                <ul>
                    <c:forEach items="${listOfConsonants}" var="consonant">
                        <li>${consonant}</li>
                    </c:forEach>
                </ul>
            </div>
            <div class="col-4">
                <h3>Punctuation marks: <%= ((Character[]) request.getAttribute("listOfPunctuationMarks")).length%></h3>
                <ul>
                    <c:forEach items="${listOfPunctuationMarks}" var="punctuationMark">
                        <li>${punctuationMark}</li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</c:if>

</body>
</html>