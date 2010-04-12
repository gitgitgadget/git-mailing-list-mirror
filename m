From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: git diff/grep add --exclude option
Date: Mon, 12 Apr 2010 23:02:06 +0200
Message-ID: <1271106125.3031.31.camel@kheops>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tUoIKNkyeh1sNOSsgd2v"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 23:02:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Qm8-0006zX-Kw
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 23:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140Ab0DLVC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 17:02:26 -0400
Received: from lo.gmane.org ([80.91.229.12]:36604 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753721Ab0DLVCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 17:02:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O1Qly-0006uc-Fi
	for git@vger.kernel.org; Mon, 12 Apr 2010 23:02:22 +0200
Received: from smj33-1-82-233-66-33.fbx.proxad.net ([82.233.66.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 23:02:22 +0200
Received: from sylvain by smj33-1-82-233-66-33.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 23:02:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: smj33-1-82-233-66-33.fbx.proxad.net
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144767>


--=-tUoIKNkyeh1sNOSsgd2v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I was surprised to not find an option to exclude file from git diff/grep
outputs like -x for diff or --exclude for grep. It's too bad because it
can be really useful.

Is something like that is planned to be implemented by somebody? I would
have loved to do it but unfortunately I'm no C developer.

Regards.

--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-tUoIKNkyeh1sNOSsgd2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkvDikYACgkQ+TklUoyVcycrKwCcDNQYkpBGKO9PfATwiHp8ppvk
XUUAn1Tre/9aa4E1RGmtOmfgocWYU1I5
=0I3Z
-----END PGP SIGNATURE-----

--=-tUoIKNkyeh1sNOSsgd2v--
