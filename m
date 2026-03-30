Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD2279DCA
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899498; cv=none; b=QcFogABgGL+y0LRrpliiB6Z3kjoNo1rr75NLX+yJ55vmTy2bayZaSLdmf+vUMmHyMfqVt768+Nt2y5CjkZ827aBKIYfFrQweTzdCf8NNSoXcfThZDZXIKriqmd/7dKP+d0UQVkWk6yEFDFDO+FOjNY+nUieNUTCTNTxXcH6pYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899498; c=relaxed/simple;
	bh=0Z8FgUKi1ieZgVvVbwOYs76cwN09BSwSEcBwRGEaZ2g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rj0I5OUof6Z/cDc1TYub+wPH9xzQ76L3oGzU/mp4F2R+9A9lBhQfRG+Tf0/0Cm/dJb8Sa0USG1NXk9+NaidJe/ohGCVz93dTp0C/sseTBz2OqyOTwaBTqQleoqGOIHcUPdocKlJk1xXTIuT64XbE9MA8Nt/MetFrtK9jrV+Iaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=uyu/Qmyt; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="uyu/Qmyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1774899481; x=1775158681;
	bh=PuEmFgmgFwSsD2wtWJDgWBTTI5RyWZ6ujISY4ev8lP4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uyu/Qmyt7VDYOUoDA6jeAeMFZVmawccTW15bdH6Ayb2bo6zfItw0rCBGeJe3Fmmhk
	 /7/dR/taBzawR+WNrCZhjFV90eS1/UfyjmaZQHj02Efntz6sdL32rBRVWfOQILwzUa
	 migx8rwN4w/J9TtI393+2/ugpi+nYPCm2yTI7yodaOMDGdUI658/fKZHHnQcrERfZA
	 6ZJPdY2kc5OqgtvDi3+hESdM4JRsBxH3I5cCdRVF1QLdd0K7m7uxXuvDLXcjWo+Ocj
	 I80CEL652KJ2X6cRoAeTfk6HQy5B4aiqKw7kl1GF5n9ZztP98tyZX3iXygQ8BWGPeP
	 mS4diRNNTD1yg==
Date: Mon, 30 Mar 2026 19:37:58 +0000
To: Corey Anderson <coreyanderson31@icloud.com>
From: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc: git@vger.kernel.org
Subject: Re: Personal information leaked
Message-ID: <n8YD4Oz1PfGQnkqeygJxJc7-gGYvkU7WfnvNM5Ryf91d7CnkGcQ6rBJ0-O4Dkl3ec6Ugc62YZD6rXAlX8p44-3HrV_4K_iIY0Va-ZGprnqY=@protonmail.com>
In-Reply-To: <6606674D-CB55-45F8-9F19-BDD9D6B5BC12@icloud.com>
References: <6606674D-CB55-45F8-9F19-BDD9D6B5BC12@icloud.com>
Feedback-ID: 31611857:user:proton
X-Pm-Message-ID: a9ae6f25a7f9d0621b0c8a0f05757bd85c8ac9d6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I recommend changing passwords first, mate.

Em s=C3=A1bado, 15 de abril de 2023 =C3=A0s 18:48, Corey Anderson <coreyand=
erson31@icloud.com> escreveu:

> My personal information is being leaked worldwide by hackers and the mali=
cious harassment and use of this site attacking my personal email violating=
 federal laws a regulations and my rights as a person with a mental disabil=
ity. Please stop processing my personal information and report to law enfor=
cement for identity theft and fraud violations.
>     Thank you,
> Corey J Anderson
>=20
> Sent from Corey J Anderson=E2=80=99s iPhone 1(314)709-9386
