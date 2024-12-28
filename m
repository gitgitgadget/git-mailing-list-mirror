Received: from qs51p00im-qukt01072701.me.com (qs51p00im-qukt01072701.me.com [17.57.155.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2035974
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735406276; cv=none; b=aD4qdwUmtNbQqtqfU3fOj8lRir4C4rw0fIYTAVy5BOFQnEi1QPfOVpcxHLv4Xcd9O+XtEtZ4YvqMFn5B/0Pymcf3F/7nXF1BVV+OMDbpxjyMNWn2ddjYsxh9xhXkxx6KPMkM/3fV1fuY2FSlfHuZiWN11llMK3oZe1Ug/nhS0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735406276; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=qDccpNTk0ZtaJqXWSzPlNCGp3rUKWPR6jrSMqvzQMxVA6nI5hDzuK35bNjG6QNEp2LHpvC59pVaYvfpeIlVF6QGKfT6ZPMYtRwhhUm5nYThNBBkPzRg8hFjBZl1RSRL17+TXXTnjE9OC8t6F8j2J0NkSclShJE4MSNoD/JAS6uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PGLUiGVb; arc=none smtp.client-ip=17.57.155.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PGLUiGVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735406273;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:
	 x-icloud-hme;
	b=PGLUiGVbjXbFw5298zXIdoIZeWkPlzWaqYquPeYWtBixK+6J9vDr0khUa7neGtlxD
	 CunrYTHo601x221I9f01hGNii+HHpQVs3WT/SfNQc6gIaAoX/yqD0K223L+mAG3qli
	 eTRlBDFW5791Adz9Aog05Ri5nMxlTH9E+hx0YqSHs3JZ7+Q5+gmNQRJxFM/d6LSje6
	 WHOEk2jNj5RnuxJZJ1+FKJS+OqlGh6+njhQLTXoh2GEzybptABbEQnNkVWo99vvtwR
	 B0jplio8LS3g4BiUi3PmjZg4mG7Ta7EdlVA9+KeDZaDap9lqowSAlIuURuFaNHEMoz
	 j7/N9D+RhdDoQ==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072701.me.com (Postfix) with ESMTPSA id 24ABB15C0373;
	Sat, 28 Dec 2024 17:17:52 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: nazifrp@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sat, 28 Dec 2024 19:34:16 +0330
Subject: Connect 
Message-Id: <79C94219-C8F2-471A-AC5A-CB9350688314@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (21F90)
X-Proofpoint-GUID: GntZPXwMLssRC-0L3HlRuQKiMkbLJFwP
X-Proofpoint-ORIG-GUID: GntZPXwMLssRC-0L3HlRuQKiMkbLJFwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-28_04,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=620 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412280148
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8


