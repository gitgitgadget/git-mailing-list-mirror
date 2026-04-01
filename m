Received: from s.wfbtzhsw.outbound-mail.sendgrid.net (s.wfbtzhsw.outbound-mail.sendgrid.net [159.183.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B610402448
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.183.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066167; cv=none; b=RkOO2n94IJd13wJeqkLQbb+zwQlHeg7rue9qFAv/XzbkuRxHth7jslcCYJovnDOb5bXYBhvGnBkn69oo9g+hQ61lwzdYiU8GOSsy5eJFDLV8uiJQnwiBAF9/44QMdqPVu7SR16GD8p1Hd9TtEow6ShCnv33JKExX/UeNi8VmBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066167; c=relaxed/simple;
	bh=VLeCmTYYsoHJOsQS8B/pY19lR2AM4MhWqI7D6a5qFpw=;
	h=Content-Type:MIME-Version:From:Subject:Message-ID:Date:To; b=dRfNA9LS7QX/0FCrsIpVg/muOzYNmBFUoze/RgTy0uavO7C0D9qViQ082wX8Rgk+IsCjf/RQdMjb1Q0mrJ7PHBIpxs+pgLdTwZ9tNmXfl9+mvYZUaD7GPxJfercOuSBcwKSqeR0tluEfpdI83HjcAvgdk8KQdePJUiDg9CwrKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=algoarena.net; spf=pass smtp.mailfrom=em3295.algoarena.net; dkim=pass (2048-bit key) header.d=algoarena.net header.i=@algoarena.net header.b=teZr0Iib; arc=none smtp.client-ip=159.183.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=algoarena.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em3295.algoarena.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=algoarena.net header.i=@algoarena.net header.b="teZr0Iib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=algoarena.net;
	h=content-type:mime-version:from:subject:date:to:cc:content-type:date:
	from:subject:to;
	s=s1; t=1775066163; bh=VLeCmTYYsoHJOsQS8B/pY19lR2AM4MhWqI7D6a5qFpw=;
	b=teZr0Iibb0NkozTVR5Bem8Fm5BMx2DRhQZ0IPfED+1GRm7LHj0LHqW8I0SnSGDDHM9L4
	hMh2XBw+evP/9ug/nNPjn1IZLuSQ5uL6LijFx+i4TshElYunjtFoyzOpjSbCNBwTIKHbP8
	MxcDNDiOJXRQuBdrO+QXTjWyrEmaVV0ckKjhc+t7F0ZmqmWh2Vd1OpUaQe5PmTa0xXaDEs
	6x8rp4YfO7K/xbi4gJODjj3sHOkKP74TFeXhd4xuAq+lCrNULOxIVOSscsR5cLOTulDLws
	IblZqFe7Wrb5M4IGEXzqkqsVvcVbSTb9dTzjisgouaKvFeRMV/3AqlDrk/tNKyzg==
Received: by recvd-59f49dd4cf-5hp8d with SMTP id recvd-59f49dd4cf-5hp8d-1-69CD5C33-5A
	2026-04-01 17:56:03.534781454 +0000 UTC m=+161975.178086472
Received: from [10.5.0.2] (unknown)
	by geopod-ismtpd-65 (SG) with ESMTP
	id WPz4a3apTQGEbed93LA5ww
	for <git@vger.kernel.org>;
	Wed, 01 Apr 2026 17:56:03.514 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============4282033784488854523=="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: AlgoArena Team <contact@algoarena.net>
Subject: Sponsorship inquiry - AlgoArena x About Git Rev News
Message-ID: <WPz4a3apTQGEbed93LA5ww@geopod-ismtpd-65>
Date: Wed, 01 Apr 2026 17:56:03 +0000 (UTC)
X-SG-EID: 
 =?us-ascii?Q?u001=2Ea88r5yf2pLuVfltUhnFCVyntmoxYKTNsro3l=2FUndSZv8CPhEpKdW0l3eW?=
 =?us-ascii?Q?yEvVjHt86TmtJQJ=2FI555QT7OpUt4s1DJUoLpM6a?=
 =?us-ascii?Q?f+2B=2FwGxjukJTSg960DiZFTmyaI2EiDRy2ANZCP?=
 =?us-ascii?Q?EdE7Xisv6n13DmKuu1F=2FhQrJQqnOHk3C2TAi24s?=
 =?us-ascii?Q?ueanMWKwRHNSPiJ+Sv5dKM5Vr1FArR=2FoJZ54HDY?=
 =?us-ascii?Q?anIQi5Xrt6hnT=2F7kAdcDHoIQj7=2FTo6=2FIUHTnJv3?=
 =?us-ascii?Q?qjFB?=
To: git@vger.kernel.org
X-Entity-ID: u001.sg53M+ErGja4vE87Qt8cCw==

--===============4282033784488854523==
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi there,

I'm Eli, co-founder of AlgoArena (https://u56123228.ct.sendgrid.net/ls/click?upn=u001.GSBinoX6HJWiAN0hfsfklLZd2K6sQvZJDFS2a3pO5Qj6oEDSjcFHz3UQNtduq3q6SWdc_m4zlf9tUolPwVATMreHtbBIF29Yci5njQiojl95ugh7M-2B3SlqWmZlVKKB0PRfr31A3p8zO-2BQqie6vccBBMkGka4LIFVlP2hge813FyABwb9uEcaGphxqtd8x8WcI3XM3C7gnlN2rDaOkRTAShBI0h9aVQcnPnYqIQWpcLzyeA4TXc1qt1yafQ2YlrYuXFLE3jiEJWh4vK-2FER2nO9-2BP1psQ-3D-3D My co-founder Andy and I built this platform to transform how people learn, build, and prove CS skills, from the classroom to the career.

Our flagship is real-time 1v1 coding battles with ELO matchmaking across 5,000+ problems in 16 languages. LeetCode meets Chess.com, competitive programming as a sport. 1,000+ matches, 500+ users. We're also launching weekly bracket tournaments with cash prizes.

We're building four products your readers would find relevant.

1. Compete. The 1v1 battles, ELO rankings, global leaderboard, and upcoming cash-prize tournaments.

2. Learn (https://u56123228.ct.sendgrid.net/ls/click?upn=u001.GSBinoX6HJWiAN0hfsfklNekJ4WQgtZSYOc-2BWsHIucVs0KTYxBKCxu-2BFzQhTA1W63kG2_m4zlf9tUolPwVATMreHtbBIF29Yci5njQiojl95ugh7M-2B3SlqWmZlVKKB0PRfr31i1mR9-2FkRPm5J7sBeEB0Cs-2BPJq-2FIGMhaTvDZ-2BCflv9SM9zwVwMBmm2L9vIxA5TcqKLpHaAPxnyuTdKMUF5-2FmRLHVEO-2FV13HJlXCxDiOUZp3yOFEPbnK4JIZiAiDozXuLeSz0I8zLOxIzuHWmGHndJ-2BQ-3D-3D Kahoot-style live CS sessions, practice roadmaps, and interactive puzzle-based learning that teaches computational thinking without requiring syntax memorization.

3. Build (coming soon). Gamified AI courses that teach prompt engineering through progressively harder puzzles, plus an agentic builder where anyone can create real apps and export to GitHub. No coding background needed.

4. Prove (https://u56123228.ct.sendgrid.net/ls/click?upn=u001.GSBinoX6HJWiAN0hfsfklLe02vvY9sRKnqapUXbwi5LBmY6hv-2BJzklf-2BwVDaNU4a-5iR_m4zlf9tUolPwVATMreHtbBIF29Yci5njQiojl95ugh7M-2B3SlqWmZlVKKB0PRfr31Y0JUvWarUTb-2FNGFE5FQghXISQwzS-2BywbesiWTpP-2F0km4mr9CaoF6cF09YiLnzeYs3rMV4r66gqf-2Fi-2FsHFgy0XVQv-2F9dwRTBz-2Fi8AfKZ6awbpCeHTD3MOk5xYh4yGOc3jeZvgWZVwlENk7ieRBmaNZQ-3D-3D AI-native assessments with a full coding environment, AI tools, session replay, and model benchmarking. There's a massive disconnect between how developers actually work and how they're tested. We capture how candidates prompt, multitask, and build, not just whether they memorized algorithms.

I'm a fan of About Git Rev News and would love to explore sponsoring an edition or placing a short feature.

Could you share your sponsorship options and rates?

Best,
Eli Young
Co-founder, AlgoArena
https://u56123228.ct.sendgrid.net/ls/click?upn=u001.GSBinoX6HJWiAN0hfsfklFS2SYhkf5Ad24X2fYor8tw-3D18fg_m4zlf9tUolPwVATMreHtbBIF29Yci5njQiojl95ugh7M-2B3SlqWmZlVKKB0PRfr31mgLX8O55tX8aP5i6ZFP5fg1-2FfS4CcsXS79Xd8gB5Iadz97bfZxDCBlAk4kgst50niE8J0mnJY-2FIbbOVnRS26pvt4Un3FxqfuGMGxJEwI128W7ggDsQfYRMQMCig7QfY9s7tq95UjS9FRLiRu-2FWPcPA-3D-3D

--===============4282033784488854523==--
