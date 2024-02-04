Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65522307
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057810; cv=none; b=MWxIApGVUo6WINpdlsOwecT+IUSfAw0IyQUiHJ12TmLNRFGDZYS5HwaMrCKuyt4u6feXSEAdN875uRoyTQ5cnCV19r2K/Hs3lj32JJ/P8Tszt0HHt9p5nFhBU1UEl37uf58RLundqxv4jkTprbc+HxqI9f4/5a87/69PnZPdM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057810; c=relaxed/simple;
	bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=uNlip/mGhvZeTwkq1Ta9QcomBzmf9mz4JzBFUxYlILf1o2KhhWn5nIqdVMjzgUZzU6FwpncIaZeEKD1jeEtB6aHUvePktzddvRqMQBsuFKbRigWmTpHhBO8I5mmzArVXE1p3yGEgNGm6Hx9uNHAWGnafZRGj4fCGnM/GkS0AkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=iNkKgcY9; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="iNkKgcY9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1707057808;
	bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=iNkKgcY959KLXc8R1r1lZft7sM4eMRsG/MrLiDbnFnjX7w8R+4p86/WH8Y9yYUihW
	 w6BbHFdsMXOrI9VkHi5Cy/yRac7iEVm3qSeSf0MmiC+97fpi7TGuRStRvwta7XH3P/
	 1JNKSy4yHOh30B+PBTJmpQ9p39AVjsAotc5Q1NpkBWFKG5WO4czZ4qqANXdViOEgRb
	 tH9gX2hoLhhECQB6n/9mIEDmNKCrIb8dE6/EfqLOfpcDXFXK/OLijGySeFmw75suQh
	 ESREplMC+Vla5I97EFcdNUBW3wzCe0Y0blBohhqy3wkyKwiPOaGo3iiIxpoBUSbM0v
	 aFJ6a+XDU6eOw==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 5BB9B3A0177
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 14:43:27 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: IPHONE <gungaung88@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 4 Feb 2024 21:43:21 +0700
Subject: cpkotsoomcsin
Message-Id: <774AE738-DB1B-48C3-B1A6-B0CB08942FF4@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (19H380)
X-Proofpoint-GUID: jHdym0qmtO8AoFIsIljrqCyhUL6Ub-4d
X-Proofpoint-ORIG-GUID: jHdym0qmtO8AoFIsIljrqCyhUL6Ub-4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 mlxlogscore=329 adultscore=0 clxscore=1011 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2402040113



Sent from my iPhone
