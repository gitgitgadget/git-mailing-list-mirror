Received: from outbound.ms.icloud.com (p-west3-cluster6-host9-snip4-5.eps.apple.com [57.103.75.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453131339A4
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.75.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745169044; cv=none; b=Q2X8GFGJdVMZU6ioeEcF9KhoC1aJFdGSg3srq/lZHHbiqQPQW4JlzMvWoQAZykd84iKgZc6Gw66WmKEoRGXW3riGmS1PxhhYeFohCLDzAm+pXC1roPOyH4TB1+fAJ3nxvPIkggTVZ2q8m3SXfqMyAda+e8Fntonm2S+a7TB1WuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745169044; c=relaxed/simple;
	bh=+1nTwYBoRz0TpHu3tMF7bZ/NCunLEbF5ncaegXDXOmo=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=DGOMa447dqXIoS1e8glUsfa8bPImbxUO57U4LlH+7vcCq/JUF652s/xeLClLkoavn0jNQx1bm9zTLmej/1xgqtgO7GLq1v8DBdeRTl17PomUI1y12fwLHHjwRhMPMwq/8aKhQYJErgn/AsijfWSkdh/NGrLRNr/qzXdvF1UhM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=qKGeGc4d; arc=none smtp.client-ip=57.103.75.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="qKGeGc4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=a4pAyZ/wa7/wWvY2NbAdmxKFxzY9PaL7/REleOm4K8g=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=qKGeGc4dqtl+ccr9BjKzPZxwJZ2DQ175BbROLHGTFgxYZ8U2Obv1D4gd2D6icq6Ug
	 7O2DYUP6/n+AghztWLpWrMdO9qx2xCXYdYeg27dmewd7w2bz1BBnL3xgRTzy3LLOuf
	 qCI1vEHnTmwu1yITFMFnlLkQMLUr1XN1PbZ2CGLm9gzrV48FHcrQFaqzxXaMgM479J
	 zEFPa+g9TqsufWlxYzYYer5GNYOPp6LwKEVuVXecl/eJEps825joLmxy1c6ODNzxJQ
	 Wz06ftD5zzEl2SQ3hdQcoIRDV/8iQNySYc7NsvuJvWPNuFd5qVw1UrF5zX/PxPtb7j
	 z6YJ5WhIEOnXQ==
Received: from smtpclient.apple (ms-asmtp-me-k8s.p00.prod.me.com [17.57.154.37])
	by outbound.ms.icloud.com (Postfix) with ESMTPSA id D8E2B1800B7C
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 17:10:37 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Jose Andres Miranda Ortega <andresmirandaramirez@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 20 Apr 2025 12:10:22 -0500
Subject: nailon list 
Message-Id: <674B0420-E151-440A-BAE2-2E1BA3E40E2E@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (22D82)
X-Proofpoint-ORIG-GUID: V1UjTQN3lpI2DEBLvvqXz4si8ptI9Egn
X-Proofpoint-GUID: V1UjTQN3lpI2DEBLvvqXz4si8ptI9Egn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-20_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=435 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1011 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504200141

dont contact me  otrabes
Enviado desde mi iPhone
