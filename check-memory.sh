#!/bin/bash

# Script pour vérifier l'utilisation de la mémoire

# Paramètres d'entrée
WARNING_THRESHOLD=$1
CRITICAL_THRESHOLD=$2

# Vérifie si les seuils sont fournis
if [ -z "$WARNING_THRESHOLD" ] || [ -z "$CRITICAL_THRESHOLD" ]; then
    echo "Usage: $0 <warning_threshold> <critical_threshold>"
    exit 3
fi

# Obtenir l'utilisation de la mémoire
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Vérification des seuils
if (( $(echo "$MEMORY_USAGE > $CRITICAL_THRESHOLD" | bc -l) )); then
    echo "CRITICAL - Memory usage is at ${MEMORY_USAGE}%"
    exit 2
elif (( $(echo "$MEMORY_USAGE > $WARNING_THRESHOLD" | bc -l) )); then
    echo "WARNING - Memory usage is at ${MEMORY_USAGE}%"
    exit 1
else
    echo "OK - Memory usage is at ${MEMORY_USAGE}%"
    exit 0
fi
