#!/bin/bash

EPOCHS=1000
BATCH_SIZE=256
ES_PATIENCE=20
REPEAT=3
MIXUP=0.4
MIXUP_REPEAT=10

for i in 0 1029 812 204 6987
do
    CUDA_VISIBLE_DEVICES=$1 \
    python -m src.training.experiments_ginfp_linearModel_MLP_only.experiment_ginfp_linear_ns_noPartial_molnet \
    -p ./data/MolNet/tox21_ginfp.json \
    -e $EPOCHS \
    -b $BATCH_SIZE \
    --es-patience $ES_PATIENCE \
    --log-path ./logs/ginfp/tox21_ns_no_mixup_no_partial \
    --repeat $REPEAT \
    --mixup-repeat $MIXUP_REPEAT \
    --learning-rate 1e-5 \
    --drop-rate 0.6 \
    --rand-seed $i
done

for i in 0 1029 812 204 6987
do
    CUDA_VISIBLE_DEVICES=$1 \
    python -m src.training.experiments_ginfp_linearModel_MLP_only.experiment_ginfp_linear_ns_noPartial_molnet \
    -p ./data/MolNet/tox21_ginfp.json \
    -e $EPOCHS \
    -b $BATCH_SIZE \
    --es-patience $ES_PATIENCE \
    --log-path ./logs/ginfp/tox21_ns_mixup_no_partial \
    --repeat $REPEAT \
    --mixup $MIXUP \
    --mixup-repeat $MIXUP_REPEAT \
    --drop-rate 0.5 \
    --rand-seed $i
done
