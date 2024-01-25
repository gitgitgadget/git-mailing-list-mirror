Received: from qs51p00im-qukt01072502.me.com (qs51p00im-qukt01072502.me.com [17.57.155.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB11339A2
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205807; cv=none; b=oKVzjTKKxrvPjEUMrTB9MO14G87Hl9tTtD+M7wLOS2Um93tzxQBBio59vlrq969qNJq9uuBsuM/P2b/CPeripAirblbtuoPbIy1nvUT4Oy0lQiK5s6Phb30r8DKbC5uUPgQakYNhZ/0OhNSD4aMAaPb3c3ztkt15HUp6SOOee6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205807; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=idlRegubJOH3gv8MqJNnA4nQOxvHiSjJsboQPtiz8w+4Xlx1TH9WgS0nlcbW69zrxQtWNPtylXGmFnM7CCNtCOftPue9kVT6lDMpxxbUpRTZVF6lwuJB5F5et6YSPrprb6kW/Sc03iUoHEnfsPSHgcl4HzpeIfzHcCgIoVXiZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PuBavugl; arc=none smtp.client-ip=17.57.155.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PuBavugl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1706205804;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=PuBavuglX8/WYATk4a9zO8C407olOiyryMotKCyvWLLdzYuP0/KADtXmKzXpVcBLA
	 VKGFtlJBCQAugK6YdEvNR8lqCtoj71686mYI5QksF2BxNElLk2KC1eF41R0lInO5Xh
	 VT25ONAB1Djge5DCYNNnXgGWkcEOgME41HY4uC4MZiCfRNTSAiX6DSnmf0bNC0liVp
	 rspmJUqDXj9KzD6emzW2uiHnLhd5hXTrj1W9tLjMqT+C2ule3ThNufdmpaj+EuSXI9
	 9S5oq+0oAs4aQ9XDsSojBi4bJx0XLlncPBE4Jc3YZBpyWhtxhEgt0uDNQr1ysqMJ0k
	 oDQZldzz9Pm+Q==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072502.me.com (Postfix) with ESMTPSA id 2D7156EC0AB4
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 18:03:24 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: John Appleseed <ars095.2029@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 25 Jan 2024 13:03:12 -0500
Subject: Seanpeytonnyc@gmail.com
Message-Id: <9356EF12-0F58-4528-9FCC-4D166178EF3E@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (21C66)
X-Proofpoint-ORIG-GUID: 3V64upilYL8yXCHDMcFHveDZ4V7eAN43
X-Proofpoint-GUID: 3V64upilYL8yXCHDMcFHveDZ4V7eAN43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_11,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=386 spamscore=0
 adultscore=0 clxscore=1011 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401250130


Sent from my iPhone
