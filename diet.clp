(deftemplate diet
	(slot cel (allowed-symbols nil fogyas tartas noveles))
	(slot sport-mennyiseg (allowed-symbols nil keves normal sok))
	(slot etkezes-frekvencia (allowed-symbols nil ritkan normal gyakran))
	(slot etel-elkeszitesi-ido (allowed-symbols nil keves normal sok))
	(slot etel-ar (allowed-symbols nil keves normal sok))
)

(deffacts d (diet))



; Szabalyok

; Pizza

(defrule pizza-tartas ""
	(declare (salience 10))
	(diet	(cel tartas)
			(sport-mennyiseg sok)
			(etkezes-frekvencia ritkan)
			(etel-elkeszitesi-ido normal)
			(etel-ar normal)
	)
=>
	(printout t "Pizza" crlf)
	(halt))
	
(defrule pizza-noveles ""
	(declare (salience 10))
	(and
		(diet	(cel noveles)
				(etkezes-frekvencia normal)
				(etel-elkeszitesi-ido normal)
				(etel-ar normal))
		(or (diet (sport-mennyiseg keves))
			(diet (sport-mennyiseg normal))))
=>
	(printout t "Pizza" crlf)
	(halt))


; Csirkemell + Rizs

(defrule csirrizs-fogyas ""
	(declare (salience 10))
	(diet	(cel fogyas)
			(sport-mennyiseg sok)
			(etkezes-frekvencia normal)
			(etel-elkeszitesi-ido sok)
			(etel-ar sok)
	)
=>
	(printout t "Csirkemell + Rizs" crlf)
	(halt))

(defrule csirrizs-tartas ""
	(declare (salience 10))
	(diet	(cel tartas)
			(sport-mennyiseg keves)
			(etkezes-frekvencia normal)
			(etel-elkeszitesi-ido sok)
			(etel-ar sok)
	)
=>
	(printout t "Csirkemell + Rizs" crlf)
	(halt))

(defrule csirrizs-noveles ""
	(declare (salience 10))
	(and
		(diet	(cel tartas)
				(etel-elkeszitesi-ido sok)
				(etel-ar sok)
		)
		(or (and (diet (sport-mennyiseg normal))
				 (or (diet (etkezes-frekvencia normal))
					 (diet (etkezes-frekvencia gyakran))))
			(and (diet (sport-mennyiseg sok))
				 (diet (etkezes-frekvencia gyakran))))
	)
=>
	(printout t "Csirkemell + Rizs" crlf)
	(halt))
	

; Puffasztott Rizs




; Kerdesek

(defrule question-cel ""
	?d <- (diet (cel nil))
=>
	(printout t "Mi a cel?" crlf)
	(printout t "	fogyas " crlf)
	(printout t "   tartas " crlf)
	(printout t "   noveles " crlf)
	(modify ?d (cel (read)))
)

(defrule question-sport-mennyiseg ""
	?d <- (diet (sport-mennyiseg nil))
=>
	(printout t "Mennyit sportolsz hetente?" crlf)
	(printout t "	keves	(0h-2h)" crlf)
	(printout t "	normal	(4h-6h)" crlf)
	(printout t "	sok		(10h +)" crlf)
	(modify ?d (sport-mennyiseg (read)))
)

(defrule question-etkezes-frekvencia ""
	?d <- (diet (etkezes-frekvencia nil))
=>
	(printout t "Mennyit ennel naponta?" crlf)
	(printout t "	ritkan	(1-2)" crlf)
	(printout t "	normal	(3)" crlf)
	(printout t "	gyakran	(5 +)" crlf)
	(modify ?d (etkezes-frekvencia (read)))
)

(defrule question-etel-elkeszitesi-ido ""
	?d <- (diet (etel-elkeszitesi-ido nil))
=>
	(printout t "Mennyi idot toltenel az etel elkeszitesevel?" crlf)
	(printout t "	keves	(2-5m)" crlf)
	(printout t "	normal	(20-40m)" crlf)
	(printout t "	sok		(1h +)" crlf)
	(modify ?d (etel-elkeszitesi-ido (read)))
)

(defrule question-etel-ar ""
	?d <- (diet (etel-ar nil))
=>
	(printout t "Mennyit koltenel ra" crlf)
	(printout t "	keves	(1000Ft -)" crlf)
	(printout t "	normal	(2000Ft)" crlf)
	(printout t "	sok		(3000Ft +)" crlf)
	(modify ?d (etel-ar (read)))
)



; Default valasz

(defrule noresp ""
                (not (item $?))
=>
         (printout t "A megadott parametereknek egyik dieta sem felel meg!" crlf)
         (halt)
    )