Received: from s.wrqvtvvn.outbound-mail.sendgrid.net (s.wrqvtvvn.outbound-mail.sendgrid.net [149.72.120.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A08724A044
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.120.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584689; cv=none; b=H5ohuZUZXnQG3o3+LP96Vqm8Ym350gL/V1sd+wrD6p7wv0J3gRmLaTjunfiax2vsR3DhJ3sDtfGtwJjzK8EMIlGTuhF3MwtPwNPP+ZrJsYeuujHQB8t4vvQJtNa+j/AYyOzA3NbfvBZORwNXPiUmlT066S+6Y85SqpIm2kvrI5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584689; c=relaxed/simple;
	bh=V4m8Q+eVChicAXM/x5jN61Salytwaga+CcZ2TsMefzY=;
	h=Content-Type:MIME-Version:From:Subject:Message-ID:Date:To; b=B4vQeoEODTQwDARucs9DoupvE6iw+nHKzPf59L1F7L7GCkCND4DswWATp9h6xIYKyZcOAaw657QzIfx2vGFvk9YnnIuOtLZZihAGb+bJoIWbJDjPZgX/hB2GOkWHdcrAP2rbVn8Yt+Ymw9L1juYhbB/2eyA9UN1sgD1HOPBoFGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=algoarena.net; spf=pass smtp.mailfrom=em3295.algoarena.net; dkim=pass (2048-bit key) header.d=algoarena.net header.i=@algoarena.net header.b=oy9daTHx; arc=none smtp.client-ip=149.72.120.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=algoarena.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em3295.algoarena.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=algoarena.net header.i=@algoarena.net header.b="oy9daTHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=algoarena.net;
	h=content-type:mime-version:from:subject:date:to:cc:content-type:date:
	from:subject:to;
	s=s1; t=1775584686; bh=V4m8Q+eVChicAXM/x5jN61Salytwaga+CcZ2TsMefzY=;
	b=oy9daTHxGY/CCkpzqi9QTa0abD0vrRH+K2XHPUyHDaJyc0iGS+qjWGgalhg9Zn/Sw6B2
	OY9COSiCwvzm0rjBOWV7oZbf88iqP0xuVyiKjzju2jr7a7XrUGIU0CY2cUzuKSkazbWjAX
	d2l0FetEHo6c6pbnlkToCbRaJieu8KdxRd7YhJzJCHa2GFx4rkkghMx0p/c7aLHg82Gsdz
	UoK0rzVzdmlBq7B4k+Ck1Jsxhk0rPXsZb1fdmDRUe6+HzhLD0eNJcufj314114I8XFv5dU
	U5RmIhqfNjK0lkDuNeVTeVsOBdSY6Eko1Cd6Nv0v9Wsu93pylVsYR5mQDSehQxcQ==
Received: by recvd-6748d45558-s8b8g with SMTP id recvd-6748d45558-s8b8g-1-69D545AE-5F
	2026-04-07 17:58:06.842217848 +0000 UTC m=+680477.357852273
Received: from dhcp-130-58-160-226.swarthmore.edu (unknown)
	by geopod-ismtpd-112 (SG) with ESMTP id 0RV1A53kS1-BlJL6HqCL5w
	for <git@vger.kernel.org>; Tue, 07 Apr 2026 17:58:06.780 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============3853296188992038209=="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: AlgoArena Team <contact@algoarena.net>
Subject: Sponsorship inquiry - AlgoArena x About Git Rev News
Message-ID: <0RV1A53kS1-BlJL6HqCL5w@geopod-ismtpd-112>
Date: Tue, 07 Apr 2026 17:58:06 +0000 (UTC)
X-SG-EID: 
 =?us-ascii?Q?u001=2Ea88r5yf2pLuVfltUhnFCVyntmoxYKTNsro3l=2FUndSZv8CPhEpKdW0l3eW?=
 =?us-ascii?Q?yEvVjHt86TmtJQJ=2FI555QT7OpUt4tdy24ditnxh?=
 =?us-ascii?Q?FGYma2=2FvYLwZld0wseTvhxaikBckXnNvCp04pBn?=
 =?us-ascii?Q?s7EcvnLRMOiNAIP9p0NJdM+Xovp=2FdJ9LNK5JCp6?=
 =?us-ascii?Q?NlKDOqN5VoLvL5IweUmZJ+L4OniBXVMh6blhD5G?=
 =?us-ascii?Q?Kos6IAiNBUGFxJ+UTIkJ6Q3iwFUw=2F6oG3YI4Myy?= =?us-ascii?Q?O15G?=
To: git@vger.kernel.org
X-Entity-ID: u001.sg53M+ErGja4vE87Qt8cCw==

--===============3853296188992038209==
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi there,

I'm Eli, co-founder of AlgoArena (https://u56123228.ct.sendgrid.net/ls/click?upn=u001.GSBinoX6HJWiAN0hfsfklLZd2K6sQvZJDFS2a3pO5Qj6oEDSjcFHz3UQNtduq3q6z4QF_m4zlf9tUolPwVATMreHtbBIF29Yci5njQiojl95ugh4t6loJJFFUHZqQoue9xS0cQWSCEjIrq3djEkcR731L4CwOS5Kz-2B1qLj-2Bn5ewLvp6JaKPhDwd7Y2VwpFGVj21EnNi-2B-2BHVBDPlzboLlgaC0OOuZdMLeIBW3zy99PhOKIcmgiBu8eNt0UBI9aKrraYe-2FaylTFdCQkma0JZsphMHEwaQ-3D-3D My co-founder Andy and I built this platform to transform how people learn, build, and prove CS skills, from the classroom to the career.

Our flagship is real-time 1v1 coding battles with ELO matchmaking across 5,000+ problems in 16 languages. LeetCode meets Chess.com, competitive programming as a sport. 1,000+ matches, 500+ users. We're also launching weekly bracket tournaments with cash prizes.

We're building four products your readers would find relevant.

1. Compete. The 1v1 battles, ELO rankings, global leaderboard, and upcoming cash-prize tournaments.

2. Learn (https://u56123228.ct.sendgrid.net/ls/click?upn=u001.GSBinoX6HJWiAN0hfsfklNekJ4WQgtZSYOc-2BWsHIucVs0KTYxBKCxu-2BFzQhTA1W6MjQ2_m4zlf9tUolPwVATMreHtbBIF29Yci5njQiojl95ugh4t6loJJFFUHZqQoue9xS0ceacwihan1zSGUUJMboGJFQh3k-2FAP3OgQ6y3FOpb9jrmgIlRoEbmAUzyPoIddGblggJc-2F2nG2rruP7brLjHRb93wfHIzW-2FUcNATjR40bR6eBuZ0KR14sSlOenvvKMwP-2FNxH3grH9vbvTVQEW2qID48A-3D-3D Kahoot-style live CS sessions, practice roadmaps, and interactive puzzle-based learning that teaches computational thinking without requiring syntax memorization.

3. Build (coming soon). Gamified AI courses that teach prompt engineering through progressively harder puzzles, plus an agentic builder where anyone can create real apps and export to GitHub. No coding background needed.

4. Prove (https://u56123228.ct.sendgrid.net/ls/click?upn=u001.GSBinoX6HJWiAN0hfsfklLe02vvY9sRKnqapUXbwi5LBmY6hv-2BJzklf-2BwVDaNU4aZlZq_m4zlf9tUolPwVATMreHtbBIF29Yci5njQiojl95ugh4t6loJJFFUHZqQoue9xS0cFzyYIezbyAmF32CORTD-2FimECPnsm-2FHsSsOS6-2BeYnGolBmPUP8LjLYktMN7dG7nzxFEz-2FJ2vvyabXesFlYDxZweEAW2Xk4pheZrda6PmIIlNBMfPsCvS7Lvhx4Wv4SWe59e36pXFR2eM3deoCt4AMew-3D-3D AI-native assessments with a full coding environment, AI tools, session replay, and model benchmarking. There's a massive disconnect between how developers actually work and how they're tested. We capture how candidates prompt, multitask, and build, not just whether they memorized algorithms.

I'm a fan of About Git Rev News and would love to explore sponsoring an edition or placing a short feature.

Could you share your sponsorship options and rates?

Best,
Eli Young
Co-founder, AlgoArena
https://u56123228.ct.sendgrid.net/ls/click?upn=u001.GSBinoX6HJWiAN0hfsfklFS2SYhkf5Ad24X2fYor8tw-3DBAck_m4zlf9tUolPwVATMreHtbBIF29Yci5njQiojl95ugh4t6loJJFFUHZqQoue9xS0cUP3lLNcPqMCTo0TfDkTodqESlK5Tr8fv49-2BV5jiqT6Ij60m1wMzWD36gVckO-2F91GiLeS4O7qANsOphNjapzlIjpMsh5skahX1Ruh7w8XiWIrTC-2FtIHLXheFsi1SvtnNHUrgHqCG-2F-2Fav3057ASRmqCQ-3D-3D

--===============3853296188992038209==--
