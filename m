Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262212BF09
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674840; cv=none; b=eiT4HyTgqvJeWe3tfrFyRC8ma7jdFPfZGE+Uw/45lNw4VMDHITaBbiU4cQ2lo+y1cnR3ho7MpBzT4iaraUArzUgblpxq0vQTDxJ9A1kzewYwX//njbeNq6QVqy5xncGdxNA6IUyTCsRNdkjRup/iUXdeYEmcsF28rgKb3KFXPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674840; c=relaxed/simple;
	bh=dQUdIoy+HH5JD7K3B0VaqZ7OwORPy6apwetPoqJtGIw=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=gADGZ5bsho/AOFqbBTD79Gp+uYrqb0+8UQpKYxBxf2Vi+pH26Er6fPP+EMjS3Uisf7m6pm18bvkWTNC05JP5xVWuU3RgWNyjs/mHKEJ5orTLJA3ixMaSZKzU1Z22OaXfvM12HzBTawuowvzGb9E7edTyq3PxZNjCiVPlmNTi+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=GUZ4YZNW; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="GUZ4YZNW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1709674838;
	bh=dQUdIoy+HH5JD7K3B0VaqZ7OwORPy6apwetPoqJtGIw=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=GUZ4YZNWv9GXcsY3vSU8YNFd/jqLeZ/xW/NoX+eG3OokZi6aSFm2cy4ggmt0kHE3N
	 Q+5ohdnn95s2lLlckP54LAGpDYgNgDtBsMeYbuNXzJg2RqpGE+d4I7qEvUgp5cwLXn
	 btGWJ52srE7fEtgwdX9nCdSM35QcG3yOf2bWTDzlvoEiBAM3tQR2vCKQx6dcnl1nlb
	 XpiiI4pAxoY0+zcb32WsZD2fmM8qMokN27E2jz458Ysc3IjdJg8ME6hIq04xkhhGZs
	 fYsnnmBU3PI0NIvc1t9gK3Q2a7XTZJVh0A1WFEAR4LMiYxq1b6dQ9AbX4y7FtZV8io
	 NrJQ9oPnH2gBw==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id F12BBC801D3
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:40:37 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Rifani mei <m4ichen@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 6 Mar 2024 04:40:27 +0700
Subject: Perorg
Message-Id: <F3F8CFE7-B8D5-45B1-A51F-762210F5A47D@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (20H307)
X-Proofpoint-GUID: sX6gXzd2X-o_bdtFCtr4csEBVphhCWPR
X-Proofpoint-ORIG-GUID: sX6gXzd2X-o_bdtFCtr4csEBVphhCWPR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_18,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=450 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403050174



Dikirim dari iPhone saya
