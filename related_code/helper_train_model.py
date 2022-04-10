'''
2022 by Shirley Li, Stanley Ho
{qiuyuli2,smho2}@illinois.edu
'''

from hyperparameters import Hyperparameters as hp
import sys
import train

models = {"birnn_concat_time_delta",
          "birnn_concat_time_delta_attention",
          "birnn_time_decay",
          "birnn_time_decay_attention",
          "ode_birnn",
          "ode_birnn_attention",
          "ode_attention",
          "attention_concat_time",
          "birnn_ode_decay",
          "birnn_ode_decay_attention",
          "mce_attention",
          "mce_birnn",
          "mce_birnn_attention",
          "logistic_regression"}
separator="===================================="

if __name__ == '__main__':
    if len(sys.argv) <= 2:
        print("Model ID and model name must be specified.")
        exit(1)

    model = sys.argv[1]
    modelName = sys.argv[2]

    if model not in models:
        print(f"Unrecognized model {model}.")
        exit(1)

    if model == "logistic_regression":
        print(f"Training for {modelName} will be performed as part of evaluation.")
        exit(0)

    print(f"{separator}")
    print(f"Training {modelName} ({model}) ...")
    print(f"{separator}")

    # Configure model to train.
    hp.net_variant = model
    # Train the model.
    train.main()
