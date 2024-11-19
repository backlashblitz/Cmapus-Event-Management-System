CREATE TABLE attendance (
    attendanceid  NUMBER NOT NULL,
    checkintime   DATE,
    user_userid   NUMBER NOT NULL,
    event_eventid NUMBER NOT NULL
);

ALTER TABLE attendance ADD CONSTRAINT attendance_pk PRIMARY KEY ( attendanceid );

CREATE TABLE club (
    clubid        NUMBER NOT NULL,
    club_name     VARCHAR2(25) NOT NULL,
    contact_email VARCHAR2(50)
);

ALTER TABLE club ADD CONSTRAINT club_pk PRIMARY KEY ( clubid );

CREATE TABLE event (
    eventid               NUMBER NOT NULL,
    title                 VARCHAR2(25),
    description           VARCHAR2(100),
    category              VARCHAR2(25),
    start_date            DATE,
    end_date              DATE,
    maximum_attendees     NUMBER,
    status                VARCHAR2(25),
    organizer_organizerid NUMBER NOT NULL
);

ALTER TABLE event ADD CONSTRAINT event_pk PRIMARY KEY ( eventid );

CREATE TABLE feedback (
    feedbackid              NUMBER NOT NULL,
    rating                  NUMBER,
    comments                VARCHAR2(100),
    submissiontime          DATE,
    attendance_attendanceid NUMBER NOT NULL,
    event_eventid           NUMBER NOT NULL
);

CREATE UNIQUE INDEX feedback__idx ON
    feedback (
        attendance_attendanceid
    ASC );

ALTER TABLE feedback ADD CONSTRAINT feedback_pk PRIMARY KEY ( feedbackid );

CREATE TABLE hosts (
    event_eventid NUMBER NOT NULL,
    venue_venueid NUMBER NOT NULL
);

ALTER TABLE hosts ADD CONSTRAINT hosts_pk PRIMARY KEY ( event_eventid,
                                                        venue_venueid );

CREATE TABLE notification (
    notificationid NUMBER NOT NULL,
    message        VARCHAR2(200),
    senttime       DATE,
    user_userid    NUMBER NOT NULL,
    event_eventid  NUMBER NOT NULL
);

ALTER TABLE notification ADD CONSTRAINT notification_pk PRIMARY KEY ( notificationid );

CREATE TABLE organizer (
    organizerid  NUMBER NOT NULL,
    organizedate DATE,
    user_userid  NUMBER NOT NULL,
    club_clubid  NUMBER NOT NULL
);

CREATE UNIQUE INDEX organizer__idx ON
    organizer (
        user_userid
    ASC );

ALTER TABLE organizer ADD CONSTRAINT organizer_pk PRIMARY KEY ( organizerid );

CREATE TABLE registration (
    registrationid   NUMBER NOT NULL,
    registrationdate DATE,
    user_userid      NUMBER NOT NULL,
    event_eventid    NUMBER NOT NULL
);

ALTER TABLE registration ADD CONSTRAINT registration_pk PRIMARY KEY ( registrationid );

CREATE TABLE "User" (
    userid                NUMBER NOT NULL,
    username              VARCHAR2(25) NOT NULL,
    password              VARCHAR2(25),
    email                 VARCHAR2(50),
    role                  VARCHAR2(25) NOT NULL,
    profile_picture       BLOB,
    preference            VARCHAR2(30),
    notification_settings VARCHAR2(25)
);

ALTER TABLE "User" ADD CONSTRAINT user_pk PRIMARY KEY ( userid );

CREATE TABLE venue (
    venueid  NUMBER NOT NULL,
    location VARCHAR2(30),
    capacity NUMBER
);

ALTER TABLE venue ADD CONSTRAINT venue_pk PRIMARY KEY ( venueid );

ALTER TABLE attendance
    ADD CONSTRAINT attendance_event_fk FOREIGN KEY ( event_eventid )
        REFERENCES event ( eventid );

ALTER TABLE attendance
    ADD CONSTRAINT attendance_user_fk FOREIGN KEY ( user_userid )
        REFERENCES "User" ( userid );

ALTER TABLE event
    ADD CONSTRAINT event_organizer_fk FOREIGN KEY ( organizer_organizerid )
        REFERENCES organizer ( organizerid );

ALTER TABLE feedback
    ADD CONSTRAINT feedback_attendance_fk FOREIGN KEY ( attendance_attendanceid )
        REFERENCES attendance ( attendanceid );

ALTER TABLE feedback
    ADD CONSTRAINT feedback_event_fk FOREIGN KEY ( event_eventid )
        REFERENCES event ( eventid );

ALTER TABLE hosts
    ADD CONSTRAINT hosts_event_fk FOREIGN KEY ( event_eventid )
        REFERENCES event ( eventid );

ALTER TABLE hosts
    ADD CONSTRAINT hosts_venue_fk FOREIGN KEY ( venue_venueid )
        REFERENCES venue ( venueid );

ALTER TABLE notification
    ADD CONSTRAINT notification_event_fk FOREIGN KEY ( event_eventid )
        REFERENCES event ( eventid );

ALTER TABLE notification
    ADD CONSTRAINT notification_user_fk FOREIGN KEY ( user_userid )
        REFERENCES "User" ( userid );

ALTER TABLE organizer
    ADD CONSTRAINT organizer_club_fk FOREIGN KEY ( club_clubid )
        REFERENCES club ( clubid );

ALTER TABLE organizer
    ADD CONSTRAINT organizer_user_fk FOREIGN KEY ( user_userid )
        REFERENCES "User" ( userid );

ALTER TABLE registration
    ADD CONSTRAINT registration_event_fk FOREIGN KEY ( event_eventid )
        REFERENCES event ( eventid );

ALTER TABLE registration
    ADD CONSTRAINT registration_user_fk FOREIGN KEY ( user_userid )
        REFERENCES "User" ( userid );