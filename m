From: Keith Packard <keithp@keithp.com>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 11:39:27 -0800
Message-ID: <1139945967.4341.71.camel@evo.keithp.com>
References: <43F20532.5000609@iaglans.de>
	 <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
	 <87k6bxvmj6.wl%cworth@cworth.org> <1139943349.4341.66.camel@evo.keithp.com>
	 <Pine.LNX.4.64.0602141101110.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xaZ0LGCKEh925SYgSELd"
Cc: keithp@keithp.com, Carl Worth <cworth@cworth.org>,
	Nicolas Vilz 'niv' <niv@iaglans.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 20:40:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F961R-0004Bn-5G
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 20:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422743AbWBNTje (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 14:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422762AbWBNTje
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 14:39:34 -0500
Received: from home.keithp.com ([63.227.221.253]:21767 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1422743AbWBNTjd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 14:39:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id C378E13002D;
	Tue, 14 Feb 2006 11:39:31 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 18984-02; Tue, 14 Feb 2006 11:39:31 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id 68A2713002C; Tue, 14 Feb 2006 11:39:31 -0800 (PST)
Received: from evo.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 5CE7E14001;
	Tue, 14 Feb 2006 11:39:31 -0800 (PST)
Received: from keithp by evo.keithp.com with local (Exim 4.60)
	(envelope-from <keithp@keithp.com>)
	id 1F961K-0005SI-10; Tue, 14 Feb 2006 11:39:30 -0800
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602141101110.3691@g5.osdl.org>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16161>


--=-xaZ0LGCKEh925SYgSELd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-02-14 at 11:04 -0800, Linus Torvalds wrote:

> Try doing that on a big project, and it will just kill you. You've also=20
> lost the "top-of-branch" info, but if you're just tracking some other=20
> tree, that's likely not an issue.

I was validating the cvs import by comparing every tagged version. Trust
me, the git tree-rewriting stage was somewhat faster than the CVS
checkout of the same content. And, as an egg, one often prefers BFI to
finesse. I had trouble figuring out precisely what sequence of commands
were needed to make git-reset --hard happy with existing bits in the
directory.    =20

--=20
keith.packard@intel.com

--=-xaZ0LGCKEh925SYgSELd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD8jHvQp8BWwlsTdMRApJoAKCfP2ko3R6/z7gDLFCRe/nXzk6o2QCfdM3V
Oy/t1PysdtWi9eX0Tq9WQ0E=
=k5MA
-----END PGP SIGNATURE-----

--=-xaZ0LGCKEh925SYgSELd--
