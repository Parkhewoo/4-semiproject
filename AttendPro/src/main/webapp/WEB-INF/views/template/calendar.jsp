<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

<style>
  #calendar {
    max-width: 100%;
    height: 400px; /* 예: 400px로 조정 */
    margin: 0 auto;
  }

  .fc-day-sat,
  .fc-day-sun {
    color: red !important; /* 토요일, 일요일 글자 색상 빨강 */
  }

  .fc-event {
    color: white; /* 이벤트 글자 색상 흰색 */
  }

  /* 이벤트 제목 가운데 정렬 */
  .fc-event-title {
    text-align: center;
    line-height: 1.5; /* 필요에 따라 조정 */
  }
</style>

<div id="calendar"></div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const calendarEl = document.getElementById('calendar');

    // JSON 문자열을 JavaScript 배열로 변환
    const holidaysJson = '${holidaysJson}';
    const holidays = JSON.parse(holidaysJson);

    // FullCalendar 설정
    const calendar = new FullCalendar.Calendar(calendarEl, {
        headerToolbar: {
            left: 'prev',
            center: 'title',
            right: 'next'
        },
        initialView: 'dayGridMonth',
        editable: false,
        expandRows: true, // 화면에 맞게 높이 재설정
        events: holidays.map(holiday => {
            // 날짜 형식 변환 (시, 분, 초 제거)
            const date = new Date(holiday.holidayDate);
            const formattedDate = date.toISOString().split('T')[0];
            
            return {
                title: '휴일',
                start: formattedDate, // '2024-09-11' 형식의 날짜 문자열
                color: 'red' // 이벤트 색상 설정
            };
        }),
        dayCellDidMount: function(info) {
            // 주말에 빨간색 글자 적용
            const date = info.date;
            if (date.getDay() === 0 || date.getDay() === 6) { // 일요일(0) 또는 토요일(6)
                info.el.style.color = 'red';
            }
        }
    });

    // 달력 렌더링
    calendar.render();
});
</script>
