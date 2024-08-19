<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <link rel="stylesheet" type="text/css" href="./commons.css">
    <!--<link rel="stylesheet" type="text/css" href="./test.css">-->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <style>
         a, input, button {
            font-size: 30px; /* 원하는 글자 크기로 변경 */
        }
        a, input {
            text-decoration: none;
        }
 
    
    </style>
</head>
<body>
    <div class="container w-1000 my-50">
        <div class="row center">
            <h1>메인화면</h1>
        </div>
        
        <div class="row mt-40 rigth flex-box">
            <a href="#" style="font-size: 16px">관리자로그인</a>
        </div>
        <div class="flex-box rigth">
            <a href="#" style="font-size: 16px;">회원가입</a>
        </div>
        <div class="row center mt-40">
            <input type="text" placeholder="사원번호 입력"><button btn><i class="fa-solid fa-circle-up"></i></button>
        </div>
        <div class="row center">
            <button type="button" class="btn btn-positive">출근</button>
            <button type="button" class="btn btn-positive">퇴근</button>
        </div>

    </div>

</body>
</html>