#!/bin/bash
# SSM 診斷腳本 - 在 private EC2 上執行

echo "=== 檢查 IAM Role ==="
curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/

echo -e "\n\n=== 檢查 IAM Credentials ==="
ROLE=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/)
curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/$ROLE | head -10

echo -e "\n\n=== 檢查 SSM Agent 狀態 ==="
sudo systemctl status amazon-ssm-agent --no-pager

echo -e "\n\n=== 檢查 SSM Agent 版本 ==="
sudo amazon-ssm-agent --version

echo -e "\n\n=== 檢查最近的 SSM Agent 日誌 ==="
sudo tail -50 /var/log/amazon/ssm/amazon-ssm-agent.log

echo -e "\n\n=== 測試網路連接到 SSM 端點 ==="
curl -I https://ssm.ap-northeast-1.amazonaws.com 2>&1 | head -5

echo -e "\n\n=== 重啟 SSM Agent ==="
sudo systemctl restart amazon-ssm-agent
sleep 5
sudo systemctl status amazon-ssm-agent --no-pager

echo -e "\n\n=== 診斷完成 ==="
