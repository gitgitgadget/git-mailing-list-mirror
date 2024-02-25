Received: from ci74p00im-qukt09082101.me.com (ci74p00im-qukt09082101.me.com [17.57.156.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B41B947
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708896898; cv=none; b=nZIHFxOI4D+43bHhXLurCJBjLPiuMQKe7KbVgPtk/12giBNvVgDwZu4Y2WzpGIJiZqTorpx2u8msFScY6V9Zs/WNOSLOYZnZDevxDOrslhbGn8sHYNkDDB8P4mmJzQrjmG3CRDO548mK5Q+OAIFYAgZOsNHhMJy3AXocymqobAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708896898; c=relaxed/simple;
	bh=AOkjb675beYvbpxLyv8tXC1l4ngvARRYNLmgbHy8w+Q=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=CXB2uMP9P7ntOIPPLKx2YRSUhseVG/2Xo9VFYa9h6ywCdvijSL2TC9AMEwjYnozZkmcO3N4YP+tgEy/+rDi7BrsoKXey3Md638BkavU2sM8BqTYNU+iiXHQvg8zM9HeAkF192+tHPdh/h+TlaBTdcMAD8Rz9XW7d95kiZpaI3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=DXtYSDoW; arc=none smtp.client-ip=17.57.156.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="DXtYSDoW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1708896896;
	bh=AOkjb675beYvbpxLyv8tXC1l4ngvARRYNLmgbHy8w+Q=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=DXtYSDoWS0rFvuiJUYfsYXbJoOnRIPqK7/ZKutCe8tZTV6hciggZEvcxbKIOWwQ+4
	 nskb2OLbZzA8IKlzNxnNE3vZGU50aNAWj4xi6uHv/OL2IDZINGhqitx9o8yQ7KfQyV
	 19ox8H131H6iVUIX6JF7xmeScQgthvU64CH0AAVqcwSfv9NMSCtTXSdNHUBaXmMJ3g
	 Y5uen46sgkWji6vi8CAc31NbXnj0r/Y7qYQ+mM4aWijOVV9WWuCgU8DMHjx05iKMTd
	 XX/SjPDxS9lQpDISzO20vRLVRC+FnseUnr/ch7JTKc5ow+VIqZ899xZbBqC5vQEp4S
	 K1+0q0HMp1L3A==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09082101.me.com (Postfix) with ESMTPSA id 4DA075600249
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 21:34:55 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Karl Rickabus <god2riff0@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 25 Feb 2024 16:34:43 -0500
Subject: Software
Message-Id: <28A5B122-A626-45EC-8E14-967A985699E2@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (20G75)
X-Proofpoint-ORIG-GUID: EcqaIhwqAOIqOkf7ZmqqmNSHr8K5yXPY
X-Proofpoint-GUID: EcqaIhwqAOIqOkf7ZmqqmNSHr8K5yXPY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_25,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=498 clxscore=1011
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2402250172

With a very satisfactory space invader, may prove controversial pretend for r=
emarkable accuracy and to the facts involved in my trapezoid.

Sent from my iPhone=
