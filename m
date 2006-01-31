From: Keith Packard <keithp@keithp.com>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 11:01:50 -0800
Message-ID: <1138734110.18852.26.camel@evo.keithp.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	 <1138446030.9919.112.camel@evo.keithp.com>
	 <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
	 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MHQzQfPUjR8z6FNlfllz"
Cc: keithp@keithp.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 20:04:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F40lP-0005Uw-UZ
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 20:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWAaTB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 14:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWAaTB6
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 14:01:58 -0500
Received: from home.keithp.com ([63.227.221.253]:52742 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751350AbWAaTB5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 14:01:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 9A3CE130021;
	Tue, 31 Jan 2006 11:01:55 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 07468-01; Tue, 31 Jan 2006 11:01:54 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id 9324113001F; Tue, 31 Jan 2006 11:01:54 -0800 (PST)
Received: from evo.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 7E55A14001;
	Tue, 31 Jan 2006 11:01:54 -0800 (PST)
Received: from keithp by evo.keithp.com with local (Exim 4.60)
	(envelope-from <keithp@keithp.com>)
	id 1F40lE-0006ZV-6D; Tue, 31 Jan 2006 11:01:52 -0800
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15333>


--=-MHQzQfPUjR8z6FNlfllz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-01-31 at 09:30 -0800, Linus Torvalds wrote:

>  - ignore it. Never _ever_ use git-update-index directly, and don't tell=20
>    people about use individual filenames to git-commit. Maybe even add=20
>    "-a" by default to the git-commit flags as a special installation=20
>    addition.

As a newly initiated user, this would have been a more gentle
introduction to the system. But, it would be hard to make it entirely
invisible given the current interfaces. I'm not sure if obscuring the
presense of the index is a great plan; it's already hard enough to
figure out how it works.

--=20
keith.packard@intel.com

--=-MHQzQfPUjR8z6FNlfllz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD37QeQp8BWwlsTdMRAlyAAKCyXfG+hdM+BFMtASGFEgNvYDvN+ACgupOW
S4wYVBxPf5m1aNM4cd3f6KY=
=2E6z
-----END PGP SIGNATURE-----

--=-MHQzQfPUjR8z6FNlfllz--
