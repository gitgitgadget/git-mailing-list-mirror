From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: question re dcommit problem
Date: Fri, 30 Jan 2009 09:42:53 +0100
Message-ID: <20090130084253.GA30046@denkbrett.schottelius.org>
References: <49824650.2070209@epstudiossoftware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Cc: git@vger.kernel.org
To: David Mann <mannd@epstudiossoftware.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 09:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSozr-0006jK-IQ
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 09:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbZA3InV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 03:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753714AbZA3InV
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 03:43:21 -0500
Received: from mx3.schottelius.org ([77.109.138.221]:55467 "EHLO
	mx3.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705AbZA3InT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 03:43:19 -0500
Received: from ikn.ethz.ch (unknown [138.188.39.203])
	by mx3.schottelius.org (Postfix) with ESMTPSA id 892C8197A055;
	Fri, 30 Jan 2009 09:43:16 +0100 (CET)
Received: by ikn.ethz.ch (Postfix, from userid 1000)
	id 2796D4938D; Fri, 30 Jan 2009 09:42:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49824650.2070209@epstudiossoftware.com>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: ikn (Linux 2.6.28-rc9-wl-denkbrett-24896-gf4f5c96 x86_64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107780>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

David Mann [Thu, Jan 29, 2009 at 07:14:08PM -0500]:
> I created a git repository from my svn repository, later uploaded it to
> GitHub, and after some branching and merging, can no longer dcommit back
> to the svn repository. [...]

Iirc git svn does not support merges. You've to use git rebase or
update through the svn server.

Sincerly,

Nico

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmCvY0ACgkQuL75KpiFGIy2xwCcD14+1L5Skjv/b2LOlAPg60he
+K8AoMITvdge2cA+2Nvsx/3dv7DJllrO
=Sef3
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
