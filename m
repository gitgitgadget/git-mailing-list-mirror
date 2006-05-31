From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] git commit --branch
Date: Wed, 31 May 2006 17:21:29 +0200
Message-ID: <20060531152129.GJ14325@admingilde.org>
References: <20060529202851.GE14325@admingilde.org> <7vr72b27x9.fsf@assigned-by-dhcp.cox.net> <20060530210551.GI14325@admingilde.org> <7vd5dvyvkq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 17:22:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlSVq-0006a0-DC
	for gcvg-git@gmane.org; Wed, 31 May 2006 17:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWEaPVb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 11:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbWEaPVb
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 11:21:31 -0400
Received: from admingilde.org ([213.95.32.146]:52098 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S965061AbWEaPVa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 May 2006 11:21:30 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FlSVl-00082o-66; Wed, 31 May 2006 17:21:29 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5dvyvkq.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21068>


--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, May 30, 2006 at 03:52:21PM -0700, Junio C Hamano wrote:
> you can switch to another existing topic branch do with "git
> checkout", perhaps with the -m flag.  While I was on the "master" to
> figure out why gitweb was not behaving for me, and figured out a mis-
> configuration that should be fixed in "newconf" topic, I switched to
> that topic and committed the fix there, after testing the change
> there.  Then either merging it back to "master" or rebuilding "master"
> from scratch based on "origin" and merging my topics got me a working
> gitweb back.

So perhaps my real problem was that I did not know about checkout -m.
Your description of the workflow is of course much saver then
automatically committing to an other branch.

--=20
Martin Waitz

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEfbR4j/Eaxd/oD7IRAuPzAJ4jISmtjO2Xxw9Y3xL4Yvs6EJfvTwCfbdua
g70IrHADoixsi9iGt0F6Pwk=
=/y5e
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--
