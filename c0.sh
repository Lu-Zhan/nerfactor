device=0

. step0.sh lego blur_data_ldr ${device}
. step0.sh chair blur_data_ldr ${device}
. step0.sh ficus blur_data_ldr ${device}
. step0.sh ficus "clear_data_low=0.1" ${device}
. step0.sh lego "clear_data_low=0.1" ${device}

# . step0.sh hotdog "clear_data_low=0.1" ${device}
# . step0.sh ficus clear_data_overexp ${device}
# . step0.sh lego clear_data_overexp ${device}
# . step0.sh materials clear_data_overexp ${device}

. step1.sh lego blur_data_ldr ${device}
. step1.sh chair blur_data_ldr ${device}
. step1.sh ficus blur_data_ldr ${device}
. step1.sh ficus "clear_data_low=0.1" ${device}
. step1.sh lego "clear_data_low=0.1" ${device}

# . step1.sh hotdog "clear_data_low=0.1" ${device}
# . step1.sh ficus clear_data_overexp ${device}
# . step1.sh lego clear_data_overexp ${device}
# . step1.sh materials clear_data_overexp ${device}

. step2.sh lego blur_data_ldr ${device}
. step2.sh chair blur_data_ldr ${device}
. step2.sh ficus blur_data_ldr ${device}
. step2.sh ficus "clear_data_low=0.1" ${device}
. step2.sh lego "clear_data_low=0.1" ${device}

# . step2.sh hotdog "clear_data_low=0.1" ${device}
# . step2.sh ficus clear_data_overexp ${device}
# . step2.sh lego clear_data_overexp ${device}
# . step2.sh materials clear_data_overexp ${device}