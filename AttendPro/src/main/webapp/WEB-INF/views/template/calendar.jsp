<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='utf-8' />
    <title>FullCalendar Example</title>
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.css' rel='stylesheet' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
    <style>
        /* 전체 화면을 차지하는 스타일 설정 */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        #calendar {
            height: 100vh; /* 뷰포트 높이의 100% */
            width: 100vw;  /* 뷰포트 너비의 100% */
        }
    </style>
</head>
<body>
    <div id='calendar'></div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,',
                    center: 'title',
                    right: 'next'
                },
                initialView: 'dayGridMonth' // 기본적으로 월 단위 보기로 설정
            });
            calendar.render();
        });
    </script>
</body>
</html>
