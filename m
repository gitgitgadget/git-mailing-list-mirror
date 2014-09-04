From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Importing from RTC to GIT
Date: Thu, 4 Sep 2014 12:55:26 +0000
Message-ID: <20140904125526.GA17505@vauxhall.crustytoothpaste.net>
References: <43622BFE4D7C4B4094E4A212BD8B2B0353B69B31C7@isifboise45.isif.state.id.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeremy Davis <Jeremy.Davis@idahosif.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 14:55:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPWZk-00017N-Ps
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 14:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbaIDMzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 08:55:38 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49959 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754309AbaIDMzg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 08:55:36 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8F4CB2808F;
	Thu,  4 Sep 2014 12:55:33 +0000 (UTC)
Mail-Followup-To: Jeremy Davis <Jeremy.Davis@idahosif.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43622BFE4D7C4B4094E4A212BD8B2B0353B69B31C7@isifboise45.isif.state.id.us>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256439>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03, 2014 at 12:22:20PM -0600, Jeremy Davis wrote:
> We really need to preserve the version history of all artifacts and
> wanted to see if there is an import utility available to do this.=C2=A0 If
> not, we can go through and import off of our milestone baselines in
> separate workspaces but this can be fairly time consuming for us to
> grab all needed baselines that we will want to preserve.=C2=A0 We are not
> planning on archiving RTC so getting the history out for all versioned
> artifacts is extremely important.

There's a git fast-import command.  If you can find a way to make RTC
output data in that format, either by using a pre-existing script or
writing one yourself, git will happily import it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUCGE+AAoJEL9TXYEfUvaLwuIP/0duWkDUFWI8eMyt4KWA4ZUr
wQjxevGmTq6r/cneI9tZGOPwwnqqK++EtLPOBKMxLPyfx5pcXLc+iz+YXDiDmTaf
cMEYhINuEyhOmCY2PQao7frVjjfA9dI34hiSulXO5tsalpT6YGmbmEAjkGQynax/
5mrfh7c/fgj9j6lu22I8jnC0D/lsn19VswFI4JIZZ9OpUNn8LiPH2V+mX56f3dXP
Py5kGwkyKf5A95dA5OxHXy5rqQe1dAI9Jyqxnea7MSUs428Ob1zDtaMjgORSFxRO
PLQZz+SQrGqz9SNJGbFquFqo8tIE56E5pNF+upm8z+yW4vMgaAqrzMVKbi9YIuZW
jn6sxH5H7ObEb3kkx3/adM5e1Jc/5g5FklR41Rp05NcqeMrTetU1bBzviFV+Zsxp
sYrHrgoJSACSBash9/X821677ppLvWknitL52cwW1SlKCjpaE3gU+PaCGWM/uO8y
Oj0fgUJnW4mImyX3agmt0j7zd6QO8Ly50e06bIrkVwuhQYSo0hIIrOVzVQPJWabc
/RbFPw9jB2fKZB1HAnqwm4vqhcq9YN+VHEaIuk7VBJhfeqMwCX4/K1coQSDeaEUX
xEjHqEWrrpVHqPQ1tAvCHKncy2cMyiNfFtsQsY/qZ8xlaQQz2HHlYkvEVp0HN32o
OntkrUHEJLoDsR3f97W8
=mBfn
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
