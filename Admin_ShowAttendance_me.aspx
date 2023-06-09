﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Admin_ShowAttendance_me.aspx.cs" Inherits="Admin_ShowAttendance_me" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
					<h1 class="h3 mb-3">Calendar</h1>

					<div class="card">
						<div class="card-header">
							<h5 class="card-title">FullCalendar</h5>
							<h6 class="card-subtitle text-muted">Open source JavaScript jQuery plugin for a full-sized, drag & drop event calendar.</h6>
						</div>
						<div class="card-body">
							<div id="fullcalendar"></div>
						</div>
					</div>

            <script src="js/app.js"></script>
        <script>
		document.addEventListener("DOMContentLoaded", function() {
			var calendarEl = document.getElementById('fullcalendar');
			var calendar = new FullCalendar.Calendar(calendarEl, {
				themeSystem: 'bootstrap',
				initialView: 'dayGridMonth',
				initialDate: '2021-07-07',
				headerToolbar: {
					left: 'prev,next today',
					center: 'title',
					right: 'dayGridMonth,timeGridWeek,timeGridDay'
				},
				events: [{
						title: 'All Day Event',
						start: '2021-07-01'
					},
					{
						title: 'Long Event',
						start: '2021-07-07',
						end: '2021-07-10'
					},
					{
						groupId: '999',
						title: 'Repeating Event',
						start: '2021-07-09T16:00:00'
					},
					{
						groupId: '999',
						title: 'Repeating Event',
						start: '2021-07-16T16:00:00'
					},
					{
						title: 'Conference',
						start: '2021-07-11',
						end: '2021-07-13'
					},
					{
						title: 'Meeting',
						start: '2021-07-12T10:30:00',
						end: '2021-07-12T12:30:00'
					},
					{
						title: 'Lunch',
						start: '2021-07-12T12:00:00'
					},
					{
						title: 'Meeting',
						start: '2021-07-12T14:30:00'
					},
					{
						title: 'Birthday Party',
						start: '2021-07-13T07:00:00'
					},
					{
						title: 'Click for Google',
						url: 'http://google.com/',
						start: '2021-07-28'
					}
				]
			});
			setTimeout(function() {
				calendar.render();
			}, 250)
		});
	</script>

</asp:Content>

