#!/bin/bash

# ==============================================================================
# WooCommerce Smart Campaigns - Start & Configure All Environments (Manual)
# ==============================================================================
# This script contains the explicit commands to start and configure all 8 test
# environments sequentially, without using a loop.
#
# Prerequisite: Run the `prepare_all_envs.sh` script first.
# Run this from the root `campaign-bay-testing/` directory.
# ==============================================================================

# Stop the script if any command fails
set -e

echo "====================================================="
echo "Starting and Configuring All 8 Test Environments..."
echo "====================================================="

# # --- Environment #1 ---
# echo ">>> Processing Environment #1: Latest WP, Latest WC, Classic"
# cd env-01
# docker compose up -d
# sleep 15
# ./setup.sh latest 10.2.0 storefront classic
# echo "--> Env #1 Ready at http://localhost:8001"
# echo ""
# cd ..

# --- Environment #2 ---
# echo ">>> Processing Environment #2: Latest WP, Oldest WC, Classic"
# cd env-02
# docker compose up -d
# sleep 15
# ./setup.sh latest 4.0.0 storefront classic
# echo "--> Env #2 Ready at http://localhost:8002"
# echo ""
# cd ..

# # --- Environment #3 ---
# echo ">>> Processing Environment #3: Oldest WP, Latest WC, Classic"
# cd env-03
# docker compose up -d
# sleep 15
# ./setup.sh 5.6 6.0.0 storefront classic
# echo "--> Env #3 Ready at http://localhost:8003"
# echo ""
# cd ..

# --- Environment #4 ---
# echo ">>> Processing Environment #4: Oldest WP, Oldest WC, Classic"
# cd env-04
# docker compose up -d
# sleep 15
# ./setup.sh 5.6 4.0.0 storefront classic
# echo "--> Env #4 Ready at http://localhost:8004"
# echo ""
# cd ..

# # --- Environment #5 ---
# echo ">>> Processing Environment #5: Latest WP, Latest WC, Block"
# cd env-05
# docker compose up -d
# sleep 15
# ./setup.sh latest 10.2.0 twentytwentyfour block
# echo "--> Env #5 Ready at http://localhost:8005"
# echo ""
# cd ..

# # --- Environment #6 ---
# echo ">>> Processing Environment #6: Latest WP, Oldest WC, Block"
# cd env-06
# docker compose up -d
# sleep 15
# ./setup.sh latest 4.0.0 twentytwentyfour block
# echo "--> Env #6 Ready at http://localhost:8006"
# echo ""
# cd ..

# --- Environment #7 ---
echo ">>> Processing Environment #7: Oldest WP, Latest WC, Legacy Default"
cd env-07
docker compose up -d
sleep 15
./setup.sh 5.6 6.0.0 twentysixteen classic
echo "--> Env #7 Ready at http://localhost:8007"
echo ""
cd ..

# # --- Environment #8 ---
# echo ">>> Processing Environment #8: Oldest WP, Oldest WC, Legacy Default"
# cd env-08
# docker compose up -d
# sleep 15
# ./setup.sh 5.6 4.0.0 twentysixteen classic
# echo "--> Env #8 Ready at http://localhost:8008"
# echo ""
# cd ..


echo "====================================================="
echo "All environments have been processed."
echo "====================================================="