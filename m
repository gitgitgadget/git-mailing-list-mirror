From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 0/5] de.po suggested updates
Date: Wed, 02 May 2012 21:13:38 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <7907002.V2EE7RxYrB@cs-pc>
References: <87d36n2f2r.fsf@thomas.inf.ethz.ch> <cover.1335966202.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 02 22:07:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPfpW-0001mN-TU
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 22:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756962Ab2EBUHM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 16:07:12 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:45237 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196Ab2EBUHL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 16:07:11 -0400
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q42JDfM1025802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 2 May 2012 21:13:41 +0200
Received: from cs-pc.localnet (e176204125.adsl.alicedsl.de [85.176.204.125])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q42JDenH009146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 May 2012 21:13:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2012-18;
	t=1335986021; bh=MVvQI/MLL3tNRLsPGFbu2zGQrVsULrpTPfSfddtBruY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=yhzh79k0JoH5qvOBjX2mvYy/317FOwh7+dHXYT2SKY7X/JdwSg2E0El80VSFtmaiS
	 5U8vzpHf+m4hB5f1dk2W4yYCMOGWIkPDq/f6zMiSnjg7che1GuWTxqikue2oXKPT1L
	 eukRufajrLU3kCrySHsK4c1Rgs+sAYJXykacx2z8=
User-Agent: KMail/4.7.3 (Linux/3.0.0-17-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <cover.1335966202.git.trast@student.ethz.ch>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196860>

Am Mittwoch, 2. Mai 2012, 15:49:22 schrieb Thomas Rast:
> The rest are for Ralf.
>=20
> [2/5] does away with the "bare"->"leer" issue that I used as an
>       example earlier.  There's precedent in git-gui :-( This does
>       raise the question if it's kosher to patch both git and git-gui
>       at the same time, but if we want to keep the translations in
>       sync it probably won't be the last such patch.
>=20
> [3/5] collects all the "obvious" stuff
>=20
> [4/5] and=20

As one of the earlier translators: I agree with all of those and I agre=
e those=20
are completely improvements. Thanks for improving the translation!

Regards,

Christian

> [5/5] gather the less-obvious stuff -- keep what you like.
>=20
> Cheers,
> Thomas
>=20
> Thomas Rast (5):
>   stash: make "saved" message translatable
>   de.po: translate "bare" as "blo=DF"
>   de.po: hopefully uncontroversial fixes
>   de.po: translate "bad" as "ung=FCltig" ("invalid")
>   de.po: collection of suggestions
>=20
>  git-gui/po/de.po |    4 +-
>  git-stash.sh     |    2 +-
>  po/de.po         |  153
> +++++++++++++++++++++++++----------------------------- 3 files change=
d, 74
> insertions(+), 85 deletions(-)
