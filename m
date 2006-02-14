From: Keith Packard <keithp@keithp.com>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 10:55:49 -0800
Message-ID: <1139943349.4341.66.camel@evo.keithp.com>
References: <43F20532.5000609@iaglans.de>
	 <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
	 <87k6bxvmj6.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3Jnp3UdTGQDwl5pKQlFV"
Cc: keithp@keithp.com, Linus Torvalds <torvalds@osdl.org>,
	Nicolas Vilz 'niv' <niv@iaglans.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 19:56:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F95LC-0002DT-2C
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 19:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbWBNSzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 13:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbWBNSzz
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 13:55:55 -0500
Received: from home.keithp.com ([63.227.221.253]:63236 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1030503AbWBNSzy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 13:55:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id DB30F13002D;
	Tue, 14 Feb 2006 10:55:52 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 18235-02; Tue, 14 Feb 2006 10:55:52 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id 7FA6A13002C; Tue, 14 Feb 2006 10:55:52 -0800 (PST)
Received: from evo.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 75BE714001;
	Tue, 14 Feb 2006 10:55:52 -0800 (PST)
Received: from keithp by evo.keithp.com with local (Exim 4.60)
	(envelope-from <keithp@keithp.com>)
	id 1F95L4-0005G0-6H; Tue, 14 Feb 2006 10:55:51 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87k6bxvmj6.wl%cworth@cworth.org>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16155>


--=-3Jnp3UdTGQDwl5pKQlFV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-02-14 at 10:10 -0800, Carl Worth wrote:

> I don't know if it's the original poster's question or not, but an
> operation I don't see in the above is "put the working files into the
> state of a given revision".

I was using:

	 rm -r *
	 rm -f .cvsignore .gitignore
	 git-reset --hard <tag>

to get to a specific tag. Of course, I cloned the repository and did
this in a separate directory; I wanted to make sure nothing 'bad'
happened to my working directory.

Creating a fake branch seemed like a lot more bother. =20
--=20
keith.packard@intel.com

--=-3Jnp3UdTGQDwl5pKQlFV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD8ie1Qp8BWwlsTdMRAtexAJ9SOBVHFVp6n1sC0EBoQq2PImpKAACguus+
/68PoBg+VBia0aTDArjXWh8=
=t8sG
-----END PGP SIGNATURE-----

--=-3Jnp3UdTGQDwl5pKQlFV--
