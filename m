Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B391C68C
	for <git@vger.kernel.org>; Fri,  3 May 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768667; cv=none; b=Zrpoqldpy17d0bKpdkNDKGdYZIXbxDU1EE2HoRGRtX11w484qR8e+1mCqzPz9DS1ajP4WEYmy5YrxeaxHQdTZFc+YdqV4WYNZGNWmb7AoM0GkTGhBQbFyo2MaO5WDvwJ7ln7ZTp+1YcYfPWVH377qfwBKzswdgQ12rNLpb6qWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768667; c=relaxed/simple;
	bh=hoKhK+2y85GHFKWr9wYAQpEIHmucGmHzUUX0n1SX4+c=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=TI/QaZ605Rx4TZcFAggHaKnlLaOy0Xru0n8B34Qrrn6fyS3X0s5/87gFuagme1g3wJ8BiT+rNfLNwNShMQ+fPFa1A0tACNhp/jYRpADg/7c42yn4aADq3jAViPfElS8UbRFLHDMPzKsG7laTRqzFg5pA24SDvYQ8y2EfkrBh5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=orange.fr; spf=pass smtp.mailfrom=orange.fr; dkim=pass (2048-bit key) header.d=orange.fr header.i=@orange.fr header.b=IOSGOa/a; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=orange.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.fr header.i=@orange.fr header.b="IOSGOa/a"
Received: from opme11oxa19nd1.rouen.francetelecom.fr ([10.110.57.110])
	by smtp.orange.fr with ESMTP
	id 2zeysbPBTC4gF2zeysAx2k; Fri, 03 May 2024 22:37:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
	s=t20230301; t=1714768656;
	bh=hoKhK+2y85GHFKWr9wYAQpEIHmucGmHzUUX0n1SX4+c=;
	h=Date:From:To:Message-ID:Subject:MIME-Version;
	b=IOSGOa/a5K/MzYN6MT/xpXkesP8rodSmoRtZjtm1TMQxhhrrUOYeb0eVX0R9rDZJT
	 kKUuNDxpUoXbzENDRglO1cvinPl5wDKrtk4twvloLSq90HSF0/IF2VD5ZxhCq4MJjW
	 MwUWgUckEnIebHvicqi3NXNW8vYZopSD1qqsJRSzLxtVT6kKO1qSjzFbMOBkOaVq35
	 89rQ/B+rZFjXHkpFO9qSQLAXgnhGgjBmnyXYQ6QkMm6Eupe+Z5Y+1qy6Eu3ulTqlG9
	 Z+fGRqATob1PYwXmOzB2a8W2Yb5auGsfmGiA7PIZrbTUPOfGwSRuz7hrUisrChBHdC
	 dvF3QP40lFKfQ==
X-ME-Helo: opme11oxa19nd1.rouen.francetelecom.fr
X-ME-Auth: bW9uaXF1ZS5yb3NzaTBAb3JhbmdlLmZy
X-ME-Date: Fri, 03 May 2024 22:37:36 +0200
X-ME-IP: 79.95.87.55
Date: Fri, 3 May 2024 22:37:36 +0200 (CEST)
From: monique rossi <monique.rossi0@orange.fr>
Reply-To: monique rossi <monique.rossi0@orange.fr>
To: git@vger.kernel.org
Message-ID: <2015405147.975890.1714768656756.JavaMail.open-xchange@opme11oxa19nd1.rouen.francetelecom.fr>
Subject: Rossi.monique
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium

Confirmation.mail


=20
Envoy=C3=A9 depuis l'application Mail Orange
