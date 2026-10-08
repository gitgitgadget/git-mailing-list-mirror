Received: from v5254.v51e342bd.use4.send.mailgun.net (v5254.v51e342bd.use4.send.mailgun.net [69.72.42.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7549B1E1
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.42.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466241; cv=none; b=kHIbsMz3KAlN98P91mjZEstdsRoOAOdJESiqh5Hf3DKaeRck+9XFKgTpQRwqRR7EMsENpxvyFXFMQva8Lazefq5VFFwzLHTHbWz/lx/qeDIzGA7SKmRvpvYZ2lRcPFTeWt/xjBaZB7vWhBHpoEo1JbCAZC0xIjJunk2BK87eSEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466241; c=relaxed/simple;
	bh=dKZBnEgFwbeSs+J2LDHo6nk+iasbxDr3gsiilrX7oFs=;
	h=Date:Mime-Version:Subject:From:To:Message-Id:Content-Type; b=sXTN18JLaYrk55Cf5KfLheu0++83OejAfrvGoQ6mgI+VbKt7w7VlT9ccNRkBoXmj3SvArVSUqLC790J/4BV77ieilSvWgeqVVx0stAnZ5RDjiWoaPPaoU1kCxGi8Yax9WHn7atrJ1AD1Nh4u1mK85M2aWxCCHI+algLHolPt3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mg.unlimitedmarketing.net; spf=pass smtp.mailfrom=mg.unlimitedmarketing.net; dkim=pass (1024-bit key) header.d=mg.unlimitedmarketing.net header.i=@mg.unlimitedmarketing.net header.b=VdEyqr/q; arc=none smtp.client-ip=69.72.42.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mg.unlimitedmarketing.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg.unlimitedmarketing.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.unlimitedmarketing.net header.i=@mg.unlimitedmarketing.net header.b="VdEyqr/q"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.unlimitedmarketing.net; q=dns/txt; s=pic; t=1791466238; x=1791473438;
 h=Content-Type: Content-Transfer-Encoding: Message-Id: Reply-To: To: To: From: From: Subject: Subject: Mime-Version: Date: Sender: Sender;
 bh=dKZBnEgFwbeSs+J2LDHo6nk+iasbxDr3gsiilrX7oFs=;
 b=VdEyqr/qJ3hUt2w2a5CcAQZ2iLgf4urhUDaqyiZZ0V2H3lQAaz6YyB4xCWJW9NwJFScvm/Ot/y5oprteBUOg3EJsCiHsBMrTP7a85acMM/sc0On4dBI8KOp8cBI6uMykCKNO/f8Wdlc4TI0NRQjDZReSXqsRTcHI56tGKopQXOI=
X-Mailgun-Sid: WyI0ODAzYSIsImdpdEB2Z2VyLmtlcm5lbC5vcmciLCIwMDI1MmYiXQ==
Received: by b06dad225e6cd63a7939b18e15144e07d4f6440d05385c061479f6e9dbab892f with HTTP
 id 6ac79afddd5e170af5ad4d44; Thu, 08 Oct 2026 13:30:37 GMT
X-Mailgun-Sending-Ip: 69.72.42.254
Sender: zaal@mg.unlimitedmarketing.net
Date: Thu, 08 Oct 2026 13:30:37 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Rate for gitforwindows.org
From: Zaal from Unlimited Marketing <zaal@mg.unlimitedmarketing.net>
To: git@vger.kernel.org
X-Mailgun-Track-Clicks: false
X-Mailgun-Track-Opens: false
X-Mailgun-Track: false
Reply-To: zaal@mg.unlimitedmarketing.net
Message-Id: <20261008133037.1f3d26129924d2e7@mg.unlimitedmarketing.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ascii

Hi,

What's the rate for a guest article on gitforwindows.org?

Zaal
