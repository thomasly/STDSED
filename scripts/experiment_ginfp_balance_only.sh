for i in {1..5}
do
    CUDA_VISIBLE_DEVICES $1 \
    python -m src.training.experiment_ginfp_balance_only \
    -p ./data/cyp450_smiles_GINfp_labels.json \
    --outside-path ./data/ChEMBL24_ginfp.hdf5 \
    -e 1000 \
    -b 128 \
    --es-patience 20 \
    --log-path ./logs/linear/chembl24_balanced_partial_no_mixup \
    --repeat 2 \
    --rand-seed $i \
done