;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1_27) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define normal_price 5.0)
(define normal_attendance 120)
(define attendee_change 15)
(define price_change .10)
(define fixed_cost 180)
(define cost_per_attendee .04)

(define (attendees ticket-price)
  (- normal_attendance (* (- ticket-price normal_price) (/ attendee_change price_change))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ fixed_cost (* cost_per_attendee (attendees ticket-price))))

(define (profit ticket-price)
    (- (revenue ticket-price)
       (cost ticket-price)))