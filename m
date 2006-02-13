From: Keith Packard <keithp@keithp.com>
Subject: Re: Handling large files with GIT
Date: Sun, 12 Feb 2006 22:07:27 -0800
Message-ID: <1139810847.4183.85.camel@evo.keithp.com>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
	 <87slqty2c8.fsf@mid.deneb.enyo.de>
	 <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
	 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
	 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org>
	 <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org> <43F01F5A.5020808@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DuGenoyptxbr4aPGwCRz"
Cc: keithp@keithp.com, Linus Torvalds <torvalds@osdl.org>,
	Ben Clifford <benc@hawaga.org.uk>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 00:50:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8nSR-0007id-TA
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 00:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWBMXuL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 18:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWBMXuK
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 18:50:10 -0500
Received: from home.keithp.com ([63.227.221.253]:55053 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1030305AbWBMXuJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 18:50:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 1046013003B;
	Mon, 13 Feb 2006 15:50:07 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06446-06-6; Mon, 13 Feb 2006 15:50:06 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id AAF85130027; Mon, 13 Feb 2006 15:50:04 -0800 (PST)
Received: from evo.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 9B3D314001;
	Mon, 13 Feb 2006 15:50:04 -0800 (PST)
Received: from keithp by evo.keithp.com with local (Exim 4.60)
	(envelope-from <keithp@keithp.com>)
	id 1F8Wrw-0005QC-R6; Sun, 12 Feb 2006 22:07:28 -0800
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <43F01F5A.5020808@pobox.com>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16088>


--=-DuGenoyptxbr4aPGwCRz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-02-13 at 00:55 -0500, Jeff Garzik wrote:
> Linus Torvalds wrote:
> > I've never used maildir layout, but if it is a couple of large _flat_=20
> > subdirectories,
>=20
> That's what it is :/   One directory per mail folder, with each email an=20
> individual file in that dir.

and, named to include a hash of the contents so that they are always
unique within a multi-folder mail store (makes refile easier).

--=20
keith.packard@intel.com

--=-DuGenoyptxbr4aPGwCRz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD8CIfQp8BWwlsTdMRAmXxAKCcrJsgz6Rvt1YnSye+tK03oeo9bwCfZzOs
M2CdXn8tN4DBHnfMNzT6nMw=
=EqRF
-----END PGP SIGNATURE-----

--=-DuGenoyptxbr4aPGwCRz--
