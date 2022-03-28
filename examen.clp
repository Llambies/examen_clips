(deffacts factores
    (robot maxCajas 3 cajas)

    (pedido naranjas 2 cajas manzanas 3 cajas uvas 1 cajas)
    (linea)

    (palet naranjas 3)
    (palet manzanas 3)
    (palet uvas 5)
    (palet caquis 5)
)


(defrule no_hay_suficientescajas
    (declare (salience 20))
    (pedido $?ini ?tipo ?cuantas cajas $?fin)
    (palet ?tipo ?stock)
    (test (< ?stock ?cuantas))
    =>
    (printout t "No hay suficientes cajas en el stock")
    (halt)
)

(defrule final
    (declare (salience 10))
    (pedido $?pedido)
    (linea $?pedido)
    =>
    (printout t "Pedido listo")
    (halt)
)

(defrule mover_frutas_stock_vacio
    (pedido $?ini ?tipo ?cuantas cajas $?fin)
    (linea $?linea)
    (robot maxCajas ?maxCajas cajas)
    (not (linea $?ini2 ?tipo ?cuantas2 cajas $?fin2))
    =>
    (assert (linea $?linea ?tipo ?cuantas cajas))
    (halt)
)