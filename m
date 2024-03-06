Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599B45479F
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714111; cv=none; b=oAQ+Qy3Bc2JptXfWuXR+CS7+y9l212ELZlsA8YXnkT7lNrDjOCyzgYY26O5znXJNJiKpqmBFzHHLsLQpc6bkh83ujzHLocTPb/z2L/Eu+z7TOCZ1erqrbG55aZmRTl4K0UZGrwUifK0y7vIz3/1Lg2YEDm8TnsyPjn8a8TPQ5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714111; c=relaxed/simple;
	bh=dQUdIoy+HH5JD7K3B0VaqZ7OwORPy6apwetPoqJtGIw=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=IDn4pBDnlZ7Z6oDsKhEdKeMK8adbLNGojHnQoEi3jecwNsFuhAAMmL1vZwy3k5RjfwkbxrS0eO+DchqHGzR24Y2FQo53Br21zQ6v3cpCN4Vleb5yVghsF8JyWOED2jIlthiiNpWZYsVtIlbja+KqtS9QwpmtOzOHKMrrsHlbZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lexkiQ/J; arc=none smtp.client-ip=17.58.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lexkiQ/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1709714108;
	bh=dQUdIoy+HH5JD7K3B0VaqZ7OwORPy6apwetPoqJtGIw=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=lexkiQ/JHvdFIlloocYFZ8/FwvGiW+rtiw27lVlwI1IOt7LbP8YlhIWaS8PjyfJSB
	 dUc8+3OY+eNQuB5SLsW0n3hUfneQAF3qOhXxz7wtYRGrDGNBxt0VuVWcVRZdH/+/xt
	 NiU+E5prIl1bVq1P15Nv7JaLj1Ds+9CCqsoxQArbD7IRytjjtSEWUjiO+kynispZVt
	 aaWF/DRHA+uRp8VT7D5mk3JspV8a+Ud5pTK7GbRyUuJq/9iCT2MCR3zSd98OuwjbED
	 Xb7DcHrNVT7EaPEJn1qLAhBQpNYF1qq3amudUmZfx7r4ZWQ5lQajZ5deqtz0VIyX4Q
	 34S20sp5WmFzA==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id AA7125001DB;
	Wed,  6 Mar 2024 08:35:07 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Rifani mei <m4ichen@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 6 Mar 2024 15:34:54 +0700
Subject: Tc
Message-Id: <DAF45700-EA17-45CA-8724-69CFAB8A2AEB@icloud.com>
To: git@vger.kernel.org, Ardi Syah Asen <yfrontdoors@gmail.com>
X-Mailer: iPhone Mail (20H307)
X-Proofpoint-ORIG-GUID: wWHGaXwCXKpbiGs_wJbBCFRce-uitNOj
X-Proofpoint-GUID: wWHGaXwCXKpbiGs_wJbBCFRce-uitNOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=645 mlxscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403060068



Dikirim dari iPhone saya
