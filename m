From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 00/11] Build in merge
Date: Sat, 21 Jun 2008 02:32:43 +0200
Message-ID: <20080621003243.GF29404@genesis.frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org> <7v4p7oq029.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4QouUtKuvByFBvSj"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 02:33:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9r3D-0000yo-LV
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 02:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbYFUAcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 20:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbYFUAcq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 20:32:46 -0400
Received: from virgo.iok.hu ([193.202.89.103]:42056 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289AbYFUAcp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 20:32:45 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 24DD91B2544;
	Sat, 21 Jun 2008 02:32:44 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2DF1A44699;
	Sat, 21 Jun 2008 02:09:49 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 87BA61190AD9; Sat, 21 Jun 2008 02:32:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v4p7oq029.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85683>


--4QouUtKuvByFBvSj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2008 at 08:04:14PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > As usual, comments are welcome. :-)
>=20
> Thanks.
>=20
> I take that last line of comment to mean "this is still RFC and not for
> inclusion yet" ;-) I think the series is fine up to eighth patch (get
> octopus merge base).

In fact only the version that had "WIP" in the subject was sent not for
inclusion. ;-)

> I'll queue the whole thing (still strictly as "test merge" basis) to 'pu';
> I've fixed 3 "old-style C function definition" issues you have in the
> tenth patch (build in merge), and I have some other issues with the ninth
> one (filter independent).

Thanks. I'm using the kernel's scripts/checkpatch.pl, but it does not
have such a check, and I missed it.

Currently I have 12 patches in my branch; if there will be no objections
to the new "filter independent" one, then I will resend the series
excluding the first 8 to avoid unnecessary traffic, if that is OK to
you.

--4QouUtKuvByFBvSj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhcTCsACgkQe81tAgORUJaVJQCeIzpO57HWk6DK9jCV5zTkewK5
jkkAoI1qBXrLw9GPG8ZY8N3JbkhUJ1hA
=bJo4
-----END PGP SIGNATURE-----

--4QouUtKuvByFBvSj--
