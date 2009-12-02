From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-commit: add --date option
Date: Wed, 2 Dec 2009 21:33:51 +0100
Message-ID: <20091202203351.GB31763@genesis.frugalware.org>
References: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
 <20091202171117.GY31763@genesis.frugalware.org>
 <7vpr6xgtxn.fsf@alter.siamese.dyndns.org>
 <20091202192425.GC30778@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hCRFYJKfs6IGypzU"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 21:33:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFvte-0006hy-J2
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 21:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbZLBUdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 15:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753614AbZLBUdq
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 15:33:46 -0500
Received: from virgo.iok.hu ([212.40.97.103]:35010 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163AbZLBUdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 15:33:46 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0A5545809B;
	Wed,  2 Dec 2009 21:33:52 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id BC83742F0A;
	Wed,  2 Dec 2009 21:33:51 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 66F571240011; Wed,  2 Dec 2009 21:33:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091202192425.GC30778@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134395>


--hCRFYJKfs6IGypzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2009 at 02:24:25PM -0500, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 02, 2009 at 09:35:48AM -0800, Junio C Hamano wrote:
>=20
> > > Is there any documentation describing what does parse_date() accept?
> > [...]
> > The above are all supported (you can label 2 as ISO even though the
> > official ISO8601 wants "T" instead of " " between date and time).
> >=20
> > For more amusing ones, see
> >=20
> >     http://article.gmane.org/gmane.comp.version-control.git/12241
> >=20
> > and follow the discussion there ;-)
>=20
> Aren't the amusing ones the result of approxidate, and not parse_date?
> At least that is my recollection from working on the date code when I
> ate 30 hot dogs last August.

I think you are right, at least --date=3D"2008-12-02 18:04:00" works here,
but not --date=3D"teatime".

--hCRFYJKfs6IGypzU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksWzy8ACgkQe81tAgORUJau+gCgn0EN6EzFRFoi1kD0TiYN4ETi
61sAnA5PT88Oh5/WXPJCdrwrJuepaPJD
=bdvW
-----END PGP SIGNATURE-----

--hCRFYJKfs6IGypzU--
