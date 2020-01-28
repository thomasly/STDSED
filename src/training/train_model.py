from tensorflow.keras.optimizers import Adam
from tensorflow.keras.callbacks import TensorBoard, EarlyStopping
from tensorflow.keras.metrics import Precision, Recall, AUC, Accuracy
import numpy as np
from sklearn.metrics import accuracy_score

def train_model(model, 
                x_train,
                y_train,
                x_test,
                y_val,
                y_eval,
                learning_rate,
                drop_rate,
                batch_size,
                epochs,
                es_patience,
                log_path,
                log_fh=None):
    """ Train model with provided training and validation data
    """
    
    ## Optimizer
    adam = Adam(learning_rate)
    ## Metrics
    precision = Precision()
    recall = Recall()
    auc = AUC()
    accuracy = Accuracy()
    ## Compile model
    model.compile(
        optimizer=adam,
        loss=model.training_loss,
        metrics=[accuracy, precision, recall, auc]
    )

    # Model training
    ## Callbacks
    tbcb = TensorBoard(log_path)
    escb = EarlyStopping("val_accuracy", patience=es_patience)
    ## fit
    model.fit(
        x=x_train,
        y=y_train,
        batch_size=batch_size,
        epochs=epochs,
        callbacks=[tbcb, escb],
        validation_data=[x_test, y_val]
    )

    # Model evaluation
    evaluation = np.round(model.predict(x_test))[:, -5:]
    acc_score = accuracy_score(
        np.squeeze(y_eval.reshape(1, -1)),
        np.squeeze(evaluation.reshape(1, -1)))

    # Show and save training results
    print("acc_score is: {}".format(acc_score))
    if log_fh is not None:
        print("acc_score is: {}".format(acc_score), file=log_fh)