From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 1/8] Docs: send-email's usage text and man page mention
	same options
Date: Sun, 28 Sep 2008 07:08:28 +0200
Message-ID: <20080928050828.GZ23137@genesis.frugalware.org>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2lX4GznBIrto1wi"
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 28 07:09:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjoXM-0005mk-BG
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 07:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbYI1FIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 01:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbYI1FIb
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 01:08:31 -0400
Received: from virgo.iok.hu ([193.202.89.103]:37905 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbYI1FIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 01:08:30 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DF3B7580B6;
	Sun, 28 Sep 2008 07:08:28 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 953DE4465E;
	Sun, 28 Sep 2008 07:08:28 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5AB2811901A1; Sun, 28 Sep 2008 07:08:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1222564196-84202-1-git-send-email-mfwitten@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96944>


--s2lX4GznBIrto1wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2008 at 08:09:49PM -0500, Michael Witten <mfwitten@MIT.EDU>=
 wrote:
> Specifically, boolean options are now listed in the form
>=20
>     --[no-]option
>=20
> and both forms of documentation now consistently use
>=20
>     --[no-]signed-off-by-cc

I don't think documenting --no-foo in the perl script itself is a good
idea. See c3170a8 (git-merge: exclude unnecessary options from
OPTIONS_SPEC, 2008-05-12) which removes --no-foo from git-merge as well.

Of course the man page part makes sense.

--s2lX4GznBIrto1wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjfEUwACgkQe81tAgORUJZ78QCfWw0SXfHIhiWwtWq7Ybr+4tim
AcsAn1tmDfPUpdMKmNy5vAcmM6P8lH6M
=esev
-----END PGP SIGNATURE-----

--s2lX4GznBIrto1wi--
