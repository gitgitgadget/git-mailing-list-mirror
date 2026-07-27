Received: from a8-200.smtp-out.amazonses.com (a8-200.smtp-out.amazonses.com [54.240.8.200])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8F32B9BB
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171491; cv=none; b=EzsM/BG3BkwhNcq1spcH8oLOWnycDLwZw6ixOR1yK64FV2CmJSaP782m3yN8D2j2NRKj0MHOomfrPOhFegL/qHz4V6JevWXqtYWJNkfngLU+Q6CDvBtptjvcY0Tjelr4mzj4htguaFFoCqCBJ6098wZOvuPv1VK8AMkIOsDaohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171491; c=relaxed/simple;
	bh=S429nn5iSpW/F1C/4kBClSPyADjFzAEmxgKGK8taHkA=;
	h=To:Subject:Date:From:Message-ID:MIME-Version:Content-Type; b=qg78ZNWAkyLSOyiBjmlwSQjT+sChMl7XG7W63Nc3z8E2k9K1cXozPfgmMcUJIxBthcF/UlExlvmoF//PBLx9yfR6Wyk5ABZNbC9kgckveUWzG0eaVFIlEkSR6uocIq6QEaoHMxLl4kzwExslp+6M5RZWkIpODyoR1DK7H4TUXDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=raphaelroy.com; spf=pass smtp.mailfrom=noreply.raphaelroy.com; dkim=pass (2048-bit key) header.d=raphaelroy.com header.i=@raphaelroy.com header.b=tHY6VbkU; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=YsdR+rVX; arc=none smtp.client-ip=54.240.8.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=raphaelroy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noreply.raphaelroy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raphaelroy.com header.i=@raphaelroy.com header.b="tHY6VbkU";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="YsdR+rVX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=43u5gga6z2q52pmft55gkjxpaaqjsdhg; d=raphaelroy.com; t=1785171483;
	h=To:Subject:Date:From:Reply-To:Message-ID:MIME-Version:Content-Type;
	bh=S429nn5iSpW/F1C/4kBClSPyADjFzAEmxgKGK8taHkA=;
	b=tHY6VbkU/rjRLNvlcKKt7g70h+ezUxcycR/3cu/UVMCCnuRSoOHL467+oJSWdSWV
	k5QKoUGbLk8PyNP6B2f7qBRfyqcUsHsPFtjNT2lu0V+OxfH0UKnCpAFUBn6GORC8OVp
	UnVHqlc55lYLhT+JiKmexnDhNMUX47OVWj7Nv9MwkT52iG+0p6lLtCj5akORmnlWLMv
	S4iu+7olCftBoqzUsDYgE87JcbyUabsKSfudcEeYFV/mSc96rofsbVp9J0K0iKO3eb7
	fY4cY8XfLaEtzvMaL7CdbcxDmpvyUxODLwSJWfdmB3jj1uXS6EkJ48OBuUOXXLVg1mH
	DNwpOWiXPg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1785171483;
	h=To:Subject:Date:From:Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
	bh=S429nn5iSpW/F1C/4kBClSPyADjFzAEmxgKGK8taHkA=;
	b=YsdR+rVXXBW5deW3UF/Oa2DbiubXctQsXpfU0IA2l0pBPAh7GJKEym2GccjErnC/
	kHjU9JnwDqiKtu0RUrYAkAPaQoi298IIp35QgBAtA3wNQQLqxbdBFiWlsKpDqrfqQXz
	Qp1KK9evDVusm1FUKj1dE0cCQDe5bvMv2J1K/d4I=
To: git@vger.kernel.org
Subject: Invitation to tender quotation for 57 market avenue
Date: Mon, 27 Jul 2026 16:58:03 +0000
From: Raphael Roy <support@raphaelroy.com>
Reply-To: clarkeinstallations@outlook.com
Message-ID: <0100019fa4831aed-172f4808-9af7-43f8-9c53-25f8c112ae19-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Feedback-ID: ::1.us-east-1.DEeGgasLUolAQ6IQaqL4ElUt6zGslePQ1pkgZpbd7zs=:AmazonSES
X-SES-Outgoing: 2026.07.27-54.240.8.200

Hi,

I trust you re having a wonderful week ahead.

I am reaching out to invite you to provide a quotation for our project at 57 Market Avenue.  If you're interested, please let me know a convenient time to send through the preliminary plans and supporting information for your review.

Kind regards,

