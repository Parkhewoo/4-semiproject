<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
  #calendar {
    max-width: 100%;
    height: 400px;
    margin: 0 auto;
  }
  .fc-day-sat, .fc-day-sun {
    color: red !important;
  }
  .fc-event {
    color: red; /* 텍스트 색상을 빨간색으로 변경 */
    background-color: transparent; /* 배경색을 투명으로 설정 */
    border: none; /* 테두리 제거 */
  }
  .fc-event-title {
    text-align: center;
    line-height: 1.5;
  }
  .selected-day {
    background-color: rgba(0, 0, 255, 0.2) !important;
  }
  .btn-my {
        padding: 8px 15px;
        font-size: 16px;
        color: #fff;
        background-color: #3498db;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn-my:hover {
    background-color: #2980b9; /* 호버 시 배경색 변경 */
}
</style>

<div id="calendar"></div>
<button class="btn-my" id="addHolidays">휴일 추가</button>
<button class="btn-my" id="removeHolidays">휴일 삭제</button>




<script>
$(document).ready(function() {
    var calendarEl = document.getElementById('calendar');

    var holidaysJson = '${holidaysJson}';
    var holidays = JSON.parse(holidaysJson);

    var selectedDates = [];
	
    // Initialize calendar
    var calendar = new FullCalendar.Calendar(calendarEl, {
        headerToolbar: {
            left: 'prev',
            center: 'title',
            right: 'next'
        },
        initialView: 'dayGridMonth',
        editable: false,
        expandRows: true,
        events: holidays.map(holiday => {
            var date = new Date(holiday.holidayDate);
            var formattedDate = date.toISOString().split('T')[0];
            return {
                id: formattedDate, // Add event id for easy removal
                title: '휴일',
                start: formattedDate,
                backgroundColor: 'transparent', // 배경색을 투명으로 설정
                borderColor: 'transparent', // 테두리 색상도 투명으로 설정
                textColor: 'red' // 글자 색상을 빨간색으로 설정
            };           
        }),
        
        dayCellDidMount: function(info) {
            var date = info.date;
            var dateStr = formatDateToISO(date); // Format date to ISO string

            if (date.getDay() === 0 || date.getDay() === 6) {
                info.el.style.color = 'red';
            }

            $(info.el).on('click', function() {
                var dateStr = formatDateToISO(date);
                var index = selectedDates.indexOf(dateStr);

                if (index === -1) {
                    selectedDates.push(dateStr);
                    $(info.el).addClass('selected-day');
                } else {
                    selectedDates.splice(index, 1);
                    $(info.el).removeClass('selected-day');
                }

                console.log("Selected Dates: ", selectedDates); // Debug log
            });
        }
    });

    calendar.render();

    
    // Add holidays to the server and calendar
    $('#addHolidays').on('click', function() {
        if (selectedDates.length > 0) {
            $.ajax({
                url: '/rest/holi/addMultiple',
                type: 'POST',
                data: {
                    companyId: '${companyDto.companyId}',
                    holidayDates: selectedDates.join(',')
                },
                success: function(response) {
                    console.log(response);
                    // Add events to the calendar
                    selectedDates.forEach(date => {
                        var event = {
                            id: date, // Use date as event id
                            title: '휴일',
                            start: date,
                            color: 'red'
                        };
                        if (!calendar.getEventById(date)) { // Add event if it does not already exist
                            calendar.addEvent(event);
                        }
                    });
                    selectedDates = []; // Clear selected dates
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        } else {
            alert('No dates selected.');
        }
    });

    // Remove holidays from the server and calendar
    $('#removeHolidays').on('click', function() {
        if (selectedDates.length > 0) {
            $.ajax({
                url: '/rest/holi/deleteMultiple',
                type: 'POST',
                data: {
                    companyId: '${companyDto.companyId}',
                    holidayDates: selectedDates.join(',')
                },
                success: function(response) {
                    console.log(response);
                    // Remove events from the calendar
                    selectedDates.forEach(date => {
                        var event = calendar.getEventById(date);
                        if (event) {
                            event.remove();
                        }
                    });
                    selectedDates = []; // Clear selected dates
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        } else {
            alert('No dates selected.');
        }
    });

    function formatDateToISO(date) {
        return new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate())).toISOString().split('T')[0];
    }
    
    
});
</script>