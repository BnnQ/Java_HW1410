<%--@elvariable id="result" type="double"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Calculator</title>
    <%@include file="imports.jsp" %>
    <style>
        .btn {
            border-radius: 3px !important;
            padding: 10px 0 !important;
            font-size: 1.15rem;
            font-weight: bold;
        }

        .button-container {
            display: grid;
            grid-template-areas: "a b c d"
                                 "e f g h"
                                 "i j k l"
                                 "m n o p"
                                 "q r s s";

            grid-gap: 5px;
        }

        #display {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="container min-vh-100 d-flex align-items-center justify-content-center">
    <div style="width: 35%">
        <h1 class="text-center">Calculator</h1>
        <%--suppress HtmlFormInputWithoutLabel --%>
        <form action="calculator" method="post">
            <input type="text" class="form-control" id="display" name="expression" value="${not empty result ? result : 0}" readonly>
            <div class="button-container">
                <button type="button" class="btn btn-warning" id="backspaceButton" style="grid-area: a">⌫</button>
                <button type="button" class="btn btn-warning" id="squareButton" style="grid-area: b">x²</button>
                <button type="button" class="btn btn-warning" id="percentButton" style="grid-area: c">%</button>
                <button type="button" class="btn btn-warning" id="divideButton" style="grid-area: d">÷</button>

                <button type="button" class="btn btn-primary" id="digit7" style="grid-area: e">7</button>
                <button type="button" class="btn btn-primary" id="digit8" style="grid-area: f">8</button>
                <button type="button" class="btn btn-primary" id="digit9" style="grid-area: g">9</button>
                <button type="button" class="btn btn-warning" id="multiplyButton" style="grid-area: h">x</button>

                <button type="button" class="btn btn-primary" id="digit4" style="grid-area: i">4</button>
                <button type="button" class="btn btn-primary" id="digit5" style="grid-area: j">5</button>
                <button type="button" class="btn btn-primary" id="digit6" style="grid-area: k">6</button>
                <button type="button" class="btn btn-warning" id="minusButton" style="grid-area: l">-</button>

                <button type="button" class="btn btn-primary" id="digit1" style="grid-area: m">1</button>
                <button type="button" class="btn btn-primary" id="digit2" style="grid-area: n">2</button>
                <button type="button" class="btn btn-primary" id="digit3" style="grid-area: o">3</button>
                <button type="button" class="btn btn-warning" id="plusButton" style="grid-area: p">+</button>

                <button type="button" class="btn btn-danger" id="clearButton" style="grid-area: q">C</button>
                <button type="button" class="btn btn-primary" id="digit0" style="grid-area: r">0</button>
                <button type="submit" class="btn btn-success" id="equalsButton" style="grid-area: s">=</button>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(() => {
        const display = $('#display');
        for (let i = 1; i <= 9; i++) {
            $('#digit' + i).bind('click', () => {
                let displayVal = display.val();
                if (displayVal === '0')
                    display.val(i);
                else
                    display.val(displayVal + i);
            });
        }

        $('#digit0').bind('click', () => {
            if (display.val() === '0')
                return;

            display.val(display.val() + '0');
        });

        $('#clearButton').bind('click', () => {
            display.val('0');
        });

        $('#backspaceButton').bind('click', () => {
            let displayVal = display.val();
            if (displayVal.length === 1) {
                display.val('0');
                return;
            }

            if (displayVal[displayVal.length - 1] === ')') {
                let indexOfBracket = displayVal.lastIndexOf('(');
                display.val(indexOfBracket === 0 ? '0' : displayVal.substring(0, indexOfBracket));
            } else {
                display.val(display.val().substring(0, display.val().length - 1));
            }

        });

        $('#squareButton').bind('click', () => {
            let displayVal = display.val();
            let numbers = displayVal.split(/[\+\-\/\*]/);
            let latestNumber = numbers[numbers.length - 1];
            display.val(displayVal.substring(0, displayVal.lastIndexOf(latestNumber)) + "(" + latestNumber + "*" + latestNumber + ")");
        });

        $('#percentButton').bind('click', () => {
            let displayVal = display.val();
            let numbers = displayVal.split(/[\+\-\/\*]/);
            let operators = displayVal.replace(/[0-9]|\./g, '').split('');

            if (numbers.length === 1) {
                display.val(numbers[0] / 100);
            } else {
                let latestNumber = numbers[numbers.length - 1];
                let preLatestNumber = numbers[numbers.length - 2];
                let lastOperator = operators[operators.length - 1];

                if (lastOperator === '+' || lastOperator === '-') {
                    let toReplace = (preLatestNumber * latestNumber / 100).toString();
                    display.val(displayVal.substring(0, displayVal.lastIndexOf(latestNumber)) + toReplace);
                } else {
                    let toReplace = (latestNumber / 100).toString();
                    display.val(displayVal.substring(0, displayVal.lastIndexOf(latestNumber)) + toReplace);
                }
            }
        });

        function isLatestSign(str) {
            let lastChar = str[str.length - 1];
            return lastChar === '+' || lastChar === '-' || lastChar === '*' || lastChar === '/';
        }

        $('#divideButton').bind('click', () => {
            const displayVal = display.val();
            if (isLatestSign(displayVal))
                return;

            display.val(displayVal + '/');
        });

        $('#multiplyButton').bind('click', () => {
            const displayVal = display.val();
            if (isLatestSign(displayVal))
                return;

            display.val(displayVal + '*');
        });

        $('#minusButton').bind('click', () => {
            const displayVal = display.val();
            if (isLatestSign(displayVal))
                return;

            display.val(displayVal + '-');
        });

        $('#plusButton').bind('click', () => {
            const displayVal = display.val();
            if (isLatestSign(displayVal))
                return;

            display.val(displayVal + '+');
        });

    });
</script>
</body>
</html>