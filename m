From: Sebastian Harl <sh@tokkee.org>
Subject: Re: [PATCH] Contributed bash completion support for core Git tools.
Date: Mon, 18 Sep 2006 10:31:16 +0200
Message-ID: <20060918083114.GQ20913@albany.tokkee.org>
References: <20060918004831.GA19851@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IfZ+tgy+ooJOsAAy"
X-From: git-owner@vger.kernel.org Mon Sep 18 10:31:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPEXB-0003ai-5F
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 10:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965576AbWIRIbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 04:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965577AbWIRIbS
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 04:31:18 -0400
Received: from mail.tokkee.org ([212.114.247.92]:64138 "EHLO albany.tokkee.org")
	by vger.kernel.org with ESMTP id S965576AbWIRIbR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 04:31:17 -0400
Received: by albany.tokkee.org (Postfix, from userid 1000)
	id 7F270364001; Mon, 18 Sep 2006 10:31:16 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060918004831.GA19851@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27244>


--IfZ+tgy+ooJOsAAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> This is a set of bash completion routines for many of the
> popular core Git tools.  I wrote these routines from scratch
> after reading the git-compl and git-compl-lib routines available
> from the gitcompletion package at http://gitweb.hawaga.org.uk/
> and found those to be lacking in functionality for some commands.

Did you talk to Ben Clifford (the maintainer of these scripts) before? His
scripts seem to be in pretty wide-spread use already, so it might make sense
to join efforts and improve his scripts (and get them into git-core).

> Consequently there may be some similarities but many differences.

Do you know of any (incompatible) differences?

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl
GnuPG-ID: 0x8501C7FC
http://tokkee.org/


--IfZ+tgy+ooJOsAAy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFDllSEFEKc4UBx/wRAndeAJ0UbtF/KSleDcWQbRMZPQ8ExfjRzwCeMV6M
lQYCNS6AMyda+vmFBzLjXMA=
=vUt2
-----END PGP SIGNATURE-----

--IfZ+tgy+ooJOsAAy--
