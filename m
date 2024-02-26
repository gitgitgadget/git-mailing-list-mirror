Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B525A5381
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708908932; cv=none; b=sz1wTXc3EMfwTetnipndbEuQ+OZj0sPwM/gsCcXbPF4YPW1FvvCO03CQkK3fIrA5uHK1nsyRiD9ULo1jzXBLawhlDXZX4QRonzjRWFcitCg19PEG/3WIAY1UNCueMn1QbqmZz5iiU8nLkTzGZ6eNT0Uinb3zTx4rwiqtceiQ1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708908932; c=relaxed/simple;
	bh=M3FaBbbwnwmPCibscdFtfSoUWdle4vcylYDd0+IcPTQ=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=jbn0fD7SE/1vCANATz2eWw6pCqYnxOUGzDcbkNN+AqMfKlwsKGxSaNnvoPKfWM5ODV6qz2z5HPOjQrPA9j4/J0LVR7SfA+Ergo1BlpxCq4tad3w/FJUhSKKTZIA7d1LGRIioQzLoFFsEZ+RmC5GA1E4iFHNVAEmjpvaewB82izo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=sF/ynteX; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="sF/ynteX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1708908931;
	bh=M3FaBbbwnwmPCibscdFtfSoUWdle4vcylYDd0+IcPTQ=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=sF/ynteX4/w1s8+o9CDKw9rKT+k/BaHCv4CmUhHRYP8NpmMb913Q0+aI35UJxeRIK
	 RXGnuocqx3RF0D0DDghk7kld9PBN7WW1A4F1mnVZz0RhNx4RzQqGNWgHfbtsc0SJbU
	 V0xCUc3DOhjt6mjSzHnEo1HlWTNdKRz0PsmXMjraQS2VBW+u8U5Att8QPvoWL5MenA
	 gedo6jB+mdb9NY9/axkA91Kbuw5xbY2MGhzaa5PswOuZ6Kw/DGKnaWZVsyAG2nVFpt
	 tKpDe1PF1ReOPmbeR2u7ld8icfGOKJqG/vjEeDVo5PG3OFrVQfabSVJRsFBUpunp3E
	 zrwdCmLWYp9dg==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 97C07C800D6
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 00:55:29 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: gooplestore11@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 26 Feb 2024 07:55:15 +0700
Subject: K
Message-Id: <A7799A29-463E-412F-80A4-8F404E624274@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPad Mail (21E5209b)
X-Proofpoint-ORIG-GUID: hC5fOARdNHxepADId6i8wuey4-m_5lU2
X-Proofpoint-GUID: hC5fOARdNHxepADId6i8wuey4-m_5lU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_28,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=421 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2402260005


Sent from my iPad
