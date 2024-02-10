Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC1259B
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707555782; cv=none; b=sIMJX/o9W3WpDqDfourFAESMICNclytx9y2s3f8NCCowOnmIH7YAMcqBHWEQlqxrfjJ8ZmPq2d5FElSlfExIjBfreNpre/w6KZzDcbY7+IbP9hxq+x1TL7I1CpUUqQmnElzOludB90kFoyunrmT3soXFTnXSKMVCzWyjaQs4sAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707555782; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=WaqbRk9WvT6MWfx0Jio9ji/5lU0FwjN+bNA+EDyzKo7PNGLkEOYPyCWRlfGMqJtHoqGNGItTkJu/hpeRCfB23nj4xzPE4xb6eByiW62lCKR7fBd34Rzbw/ZR5bDxyc3TkcJ5Xe+79GRUeX/JrExmi58e+NpXMMLidTlJ9XMiwZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=neZc+HI5; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="neZc+HI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1707555780;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=neZc+HI5bHW5LUmKbtCbu0QsW2BUJlz13xRhacqDFPb6NjoBsQT/lG5Sof35fAE+o
	 Y+5HIqAK/1d3BxE9q6gxrjvQhreWWp/PpcKmBtRs+dWSiiguEaM8U+cd7LAFWYcaBS
	 FlkvBVrVfLfOmUGQRacn5mNCWk8Xh/RDY1sGZs7+odnb6Wv4pOZkL+wJaOqDACfSy2
	 jGi+H4SdaBvYSoM00Wq856mrtgI13sIsKrtCaAO/1+nrrvDvzuyjHOUicxk1EuNySn
	 wwgJ9muoTX4aGadYupcSUFYh9XmFxIhn583UmwkKtYFsuliL84ReoMg0rSbFwMvCVE
	 yYv+mxfAvvABw==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id CA9574A0180;
	Sat, 10 Feb 2024 09:02:58 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Ashok Sharma <ashoksharma09484392@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sat, 10 Feb 2024 17:02:45 +0800
Subject: Open Apple Store 
Message-Id: <18A33BB8-51B3-45EE-A485-FEED6BB08C30@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (21D61)
X-Proofpoint-ORIG-GUID: COXhV0ZetVsSv5HiPF8Ze2Htkpjng3-q
X-Proofpoint-GUID: COXhV0ZetVsSv5HiPF8Ze2Htkpjng3-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-10_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 mlxlogscore=584 malwarescore=0 clxscore=1011 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2402100075


Sent from my iPhone

