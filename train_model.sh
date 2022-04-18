#!/bin/bash
#
# 2022 by Shirley Li, Stanley Ho
# {qiuyuli2,smho2}@illinois.edu
#

PS3='Which model do you want to train? '
options=("ODE + RNN + Attention" \
         "ODE + RNN" \
         "RNN (ODE time delay) + Attention" \
         "RNN (ODE time delay)" \
         "RNN (exp time delay) + Attention" \
         "RNN (exp time delay)" \
         "RNN (concatenated time delta) + Attention" \
         "RNN (concatenated time delta)" \
         "ODE + Attention" \
         "Attention (concatenated time)" \
         "MCE + RNN + Attention" \
         "MCE + RNN" \
         "MCE + Attention" \
         "Logistic Regression" \
         "*ABLATION* RNN + Attention" \
         "*ABLATION* RNN" \
         "QUIT")
separator="===================================="
model=""
modelName=""

select opt in "${options[@]}"
do
    case $opt in
        "ODE + RNN + Attention")
            model="ode_birnn_attention"
            modelName=$opt
            break
            ;;
        "ODE + RNN")
            model="ode_birnn"
            modelName=$opt
            break
            ;;
        "RNN (ODE time delay) + Attention")
            model="birnn_ode_decay_attention"
            modelName=$opt
            break
            ;;
        "RNN (ODE time delay)")
            model="birnn_ode_decay"
            modelName=$opt
            break
            ;;
        "RNN (exp time delay) + Attention")
            model="birnn_time_decay_attention"
            modelName=$opt
            break
            ;;
        "RNN (exp time delay)")
            model="birnn_time_decay"
            modelName=$opt
            break
            ;;
        "RNN (concatenated time delta) + Attention")
            model="birnn_concat_time_delta_attention"
            modelName=$opt
            break
            ;;
        "RNN (concatenated time delta)")
            model="birnn_concat_time_delta"
            modelName=$opt
            break
            ;;
        "ODE + Attention")
            model="ode_attention"
            modelName=$opt
            break
            ;;
        "Attention (concatenated time)")
            model="attention_concat_time"
            modelName=$opt
            break
            ;;
        "MCE + RNN + Attention")
            model="mce_birnn_attention"
            modelName=$opt
            break
            ;;
        "MCE + RNN")
            model="mce_birnn"
            modelName=$opt
            break
            ;;
        "MCE + Attention")
            model="mce_attention"
            modelName=$opt
            break
            ;;
        "Logistic Regression")
            model="logistic_regression"
            modelName=$opt
            break
            ;;
        "*ABLATION* RNN + Attention")
            model="birnn_attention"
            modelName=$opt
            break
            ;;
        "*ABLATION* RNN")
            model="birnn"
            modelName=$opt
            break
            ;;
        "QUIT")
            exit 0
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

# Train specific model.
cd ./related_code
python3 ./helper_train_model.py "$model" "$modelName"
exit $?
