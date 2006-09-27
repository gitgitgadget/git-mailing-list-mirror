From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Wed, 27 Sep 2006 11:16:20 +0200
Message-ID: <20060927091620.GB8056@admingilde.org>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Cc: git@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Wed Sep 27 11:16:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSVWj-0008UC-M9
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 11:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965464AbWI0JQW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 05:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965465AbWI0JQW
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 05:16:22 -0400
Received: from agent.admingilde.org ([213.95.21.5]:52100 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S965464AbWI0JQV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 05:16:21 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GSVWe-0003GV-4G; Wed, 27 Sep 2006 11:16:20 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27893>


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Sep 26, 2006 at 07:40:53PM -0700, Junio C Hamano wrote:
>  .gitignore                       |    1
>  Documentation/git-tar-tree.txt   |    3 +++++++++
>  Documentation/git-upload-tar.txt |   39 -----------------------------
>  Documentation/git.txt            |    4 -----------
>  Makefile                         |    1
>  builtin-tar-tree.c               |  130 +++++++++++++++-----------------=
------
>  builtin-upload-tar.c             |   74 --------------------------------=
--
>  git.c                            |    1
>  8 files changed, 53 insertions(+), 200 deletions(-)

hmm, the small changes (1 line) are still not shown :-(.
I like the idea of non-linear display, but we have to fine-tune the
algorithm a little bit more.

--=20
Martin Waitz

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFGkFkj/Eaxd/oD7IRAiXBAJ91Un0KzvOtK21LG+2PKeVGMGYLcACfcv/T
X2NS1sb/SefeptgLO9cvrNE=
=Byt3
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
