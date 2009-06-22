From: "Alexey I. Froloff" <raorn@altlinux.org>
Subject: most annoying thing in git-push
Date: Mon, 22 Jun 2009 23:21:47 +0400
Message-ID: <20090622192147.GE5743@altlinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 21:25:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIp8k-0003tj-Mb
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 21:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbZFVTZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 15:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbZFVTZD
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 15:25:03 -0400
Received: from main.gmane.org ([80.91.229.2]:47762 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbZFVTZC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 15:25:02 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MIp8Y-0008WD-OQ
	for git@vger.kernel.org; Mon, 22 Jun 2009 19:25:02 +0000
Received: from 213.85.39.63 ([213.85.39.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 19:25:02 +0000
Received: from raorn by 213.85.39.63 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 19:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 213.85.39.63
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122056>


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom git-fetch(1), -n option description: "By default, tags that
point at objects that are downloaded from the remote repository
are fetched and stored locally."

Is is possible to add such functionality to git-push, so it will
push tags that point at objects that were uploaded to the remote
repository?

--=20
Regards,
Sir Raorn.

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko/2csACgkQVqT7+fkT8wpcYACgiyRHG4BKLGD8QHwNtb/zm4nK
RJQAnA9NTG8YEv7414AtUgwhNhJwgvBG
=lZfy
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
