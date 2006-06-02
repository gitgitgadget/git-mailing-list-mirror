From: Martin Waitz <tali@admingilde.org>
Subject: Re: git reset --hard not removing some files
Date: Fri, 2 Jun 2006 16:17:24 +0200
Message-ID: <20060602141724.GM14325@admingilde.org>
References: <20060601160052.GK14325@admingilde.org> <Pine.LNX.4.64.0606010918060.5498@g5.osdl.org> <20060602093736.GL14325@admingilde.org> <20060602060820.8eebe391.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8884J15jRwcBTvu"
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 16:17:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmAT4-0003bN-Mu
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 16:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWFBOR2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 10:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWFBOR2
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 10:17:28 -0400
Received: from admingilde.org ([213.95.32.146]:16807 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932155AbWFBOR1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 10:17:27 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FmASq-00018I-Ih; Fri, 02 Jun 2006 16:17:24 +0200
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20060602060820.8eebe391.seanlkml@sympatico.ca>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21160>


--n8884J15jRwcBTvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Jun 02, 2006 at 06:08:20AM -0400, Sean wrote:
> Strange.. this little test shows that tracked files that are ignored
> do get removed when resetting --hard...

ok, git must be behaving correctly then, I don't know what problem I ran in=
to.
Must have been some kind of user error...

--=20
Martin Waitz

--n8884J15jRwcBTvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEgEh0j/Eaxd/oD7IRAqw5AJ0ftQ6mIw+SCloqhTdBy98PvHJGBwCfV4QJ
XCBuFSCkTxBnFcuLKgZ+YxI=
=ay3S
-----END PGP SIGNATURE-----

--n8884J15jRwcBTvu--
