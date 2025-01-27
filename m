Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BA34545
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737944994; cv=none; b=tP/Sulyz7Sz03Irhzum7734Rp/DuwK88Uin8vd5mrYZivpmIoytVyl9CdkpG2EaAKqLVwpn4e4doDRj2D2L8zVAq9cRd/cz1Vl/iB6PKYqJLoH3oAPd7eeh3nQWp45SMWeiNeOIaJmwF0Kr6thiJe0CzgwNuzU4PBiNhDRVwUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737944994; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=J/TULYPfPFvJCqTckweegN6eRV/SEeFquaws4DXjcG/u4QluEbubB7yPwX0FL3b03FkXL2cY59ydwyd2s5OfXE0gXfqJKFEkSPyS3aRUhnj59rY9Y/dcnuqcR94XuBTSm8g1QaoYjimrvnrMJVlxSw+yUa3/+ZS6xqilzyRjoHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=OlEzf2Fu; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="OlEzf2Fu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=OlEzf2FuaXoFtTk+A3DeYO0YSxVgCUqKej8IuvPPTBiEtqkx6P/mjPVcv9SxeGT8W
	 VmAxXJIGeWjnQj3G2eGBZ8dHCgtJd0SUqYxN+/h01Bpp8dfOpqKydP5UOAqQyFZ6hG
	 /XQ/XoE9TJ5IC5p+hKWDRc8tqg+8aqw1UeLawR+RCK1NYQi9syBVAIrmisI+XgI7gc
	 Rpr1452EPKHRzIjkXs7HvIlgE9ZBzyRKIPQn0L/9nUQGeMeB1TiWru8XfUvbMIESUp
	 mr5QgVloqe3z3oWN+FGeG7vcim2hidytouuAlbrjKdUyDQtBo3lPly3avHWIyIt0GQ
	 nQLGvpmxCnF9A==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 9C5CBCC6816
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 02:29:50 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: anandhukrishna <anandhu00@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 27 Jan 2025 07:39:10 +0530
Subject: Plz stop
Message-Id: <968FA6A3-8DC4-4EFD-AEB4-9DA367432621@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (22C161)
X-Proofpoint-ORIG-GUID: -92_cgRcCtjSVsjMNi_LxYDexgy-At7A
X-Proofpoint-GUID: -92_cgRcCtjSVsjMNi_LxYDexgy-At7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_10,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1011
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=445 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501270018


Sent from my iPhone
