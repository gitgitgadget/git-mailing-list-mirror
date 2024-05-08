Received: from smtp.frotanarede.com.br (smtp.frotanarede.com.br [187.72.53.89])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCC1823BC
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=187.72.53.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166204; cv=none; b=m5pD2/D9i6mh7CzrosdQaNRFXvcV0PhHxklpcWlGNbwC9IvAmLdmtulJsy3q1uPoqbRUtQdno29PBhSIhp8ZElAdoEGf1Rp/1S0sJu2L70iLl9Ktoj73knqBKNp+31ifxlQHlI0a66a56A+TZmxvYUr8Ob52XIHV8+t8M7NjPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166204; c=relaxed/simple;
	bh=737AcDcbsFTPQNP4xEaJNrKtPCVwOsVMVOY1Z3A4Eak=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WT3DPKMTpQepsINMupMaWtfZOWnDHNzdOyc+1sAuHh6DqQF+a0MeaeURt+Kp2zu51ALeEtd6fWf172vguqf5cPj4nzOgzVgq28kBFAYQrDiGx8wetfEYJDd2mhS4MNSR/iINzL8xTfUTD05qpeqV4Mjw1+OhWu4FNYJKQxDK2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=frotanarede.com.br; spf=pass smtp.mailfrom=frotanarede.com.br; dkim=pass (1024-bit key) header.d=frotanarede.com.br header.i=@frotanarede.com.br header.b=mnv4BMpR; arc=none smtp.client-ip=187.72.53.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=frotanarede.com.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frotanarede.com.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=frotanarede.com.br header.i=@frotanarede.com.br header.b="mnv4BMpR"
Received: from localhost (localhost [127.0.0.1])
	by smtp.frotanarede.com.br (Postfix) with ESMTP id 5807B45AE86
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:42:24 -0300 (-03)
Received: from smtp.frotanarede.com.br ([127.0.0.1])
	by localhost (smtp.frotanarede.com.br [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 3PIwq74B6MTh for <git@vger.kernel.org>;
	Wed,  8 May 2024 07:42:24 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
	by smtp.frotanarede.com.br (Postfix) with ESMTP id 3D65545CA10
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:34:54 -0300 (-03)
DKIM-Filter: OpenDKIM Filter v2.9.0 smtp.frotanarede.com.br 3D65545CA10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=frotanarede.com.br;
	s=552EDE96-BC5A-11EE-A282-D59B0C92D650; t=1715164494;
	bh=737AcDcbsFTPQNP4xEaJNrKtPCVwOsVMVOY1Z3A4Eak=;
	h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	b=mnv4BMpR/n++EaYyrCOWXhhqsPkPVv9wls4TRvT4hTNsqvcIvCXeS5HWIDnXbz5cM
	 w+3/pvL4eMM4p0U/XAzUKPabFASoyXp2j46elhzYL5I+tP6yQgtrAzfedutLPrFlzQ
	 V2KEd30y0T3pVMB8e+obXk6vHyX0e/wHnR28wzyU=
X-Virus-Scanned: amavisd-new at frotanarede.com.br
Received: from smtp.frotanarede.com.br ([127.0.0.1])
	by localhost (smtp.frotanarede.com.br [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0fhQey1OCa4Q for <git@vger.kernel.org>;
	Wed,  8 May 2024 07:34:54 -0300 (-03)
Received: from frotanarede.com.br (unknown [172.210.36.97])
	by smtp.frotanarede.com.br (Postfix) with ESMTPSA id A0D5845BFA4
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:29:34 -0300 (-03)
Reply-To: dhees@exxmobil.com
From: Dick Van Hees <saa_app@frotanarede.com.br>
To: git@vger.kernel.org
Subject: Greetings
Date: 08 May 2024 10:28:57 +0000
Message-ID: <20240508102857.D5B8EFBE827578A6@frotanarede.com.br>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,


Refer to: Project/Business Financing.

As a financial consultant and business facilitator, my name is=20
Dick Van Hees. I work for a financial consulting firm with=20
respectable investors who are growing their global footprint by=20
funding projects and enterprises that have potential all over the=20
world. Through debt financing, they presently offer financial=20
support to people and businesses for project and business=20
expansion.

Please contact me if you are looking for funds to invest in or=20
expand your project or business. We would be happy to work with=20
you.

If you recommend someone who could be interested in this offer,=20
you will receive a commission from us; if not, disregard the=20
message.

Regards,
Dick Van Hees
