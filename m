From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Thu, 06 Apr 2006 13:12:36 -0700
Message-ID: <1144354356.2303.270.camel@neko.keithp.com>
References: <20060405174247.GA29758@blackbean.org>
	 <1144262498.2303.231.camel@neko.keithp.com>
	 <20060406181502.GA15741@blackbean.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-O4DYk4UaIPow/V4v3OCm"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 06 22:13:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRaqw-0005IY-DF
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 22:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWDFUNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 16:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDFUNM
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 16:13:12 -0400
Received: from home.keithp.com ([63.227.221.253]:30729 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751143AbWDFUNK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 16:13:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 952A1130020;
	Thu,  6 Apr 2006 13:13:06 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 16684-02; Thu, 6 Apr 2006 13:13:06 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 1AB7613001F; Thu,  6 Apr 2006 13:13:06 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 8D3F114001;
	Thu,  6 Apr 2006 13:13:05 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id B451E543DB; Thu,  6 Apr 2006 13:12:36 -0700 (PDT)
To: Jim Radford <radford@blackbean.org>
In-Reply-To: <20060406181502.GA15741@blackbean.org>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18479>


--=-O4DYk4UaIPow/V4v3OCm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-04-06 at 11:15 -0700, Jim Radford wrote:
> Hi Keith,
>=20
> Here's one more build patch.  For some reason the Fedora lex doesn't
> want a space after the -o.

I probably shouldn't even use the -o flag; all it does is change the
#line directives in the output file to point at lex.c instead of
<stdout>. I'm sure it'll break something.

> Almost all of the errors I was seeing in the last version were fixed
> with your "branches that don't get merged back to the trunk" fix.

That's good news at least.

--=20
keith.packard@intel.com

--=-O4DYk4UaIPow/V4v3OCm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBENXY0Qp8BWwlsTdMRAsn4AJ0WmMG2BPTrOxfA+P3qc8A8eGGEbgCdG1te
Q2rMKGIe5xhE1C3bjAK1jPw=
=2Wqn
-----END PGP SIGNATURE-----

--=-O4DYk4UaIPow/V4v3OCm--
