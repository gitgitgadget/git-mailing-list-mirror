From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-commit: add --date option
Date: Wed, 2 Dec 2009 22:40:34 +0100
Message-ID: <20091202214034.GD31763@genesis.frugalware.org>
References: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
 <20091202171117.GY31763@genesis.frugalware.org>
 <7vpr6xgtxn.fsf@alter.siamese.dyndns.org>
 <7vaay1gt0z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6ys2uLYBf50XP5fk"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 22:40:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFwwM-0003my-8V
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 22:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562AbZLBVkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 16:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755535AbZLBVki
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 16:40:38 -0500
Received: from virgo.iok.hu ([212.40.97.103]:42005 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754300AbZLBVk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 16:40:29 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1B37E580A5;
	Wed,  2 Dec 2009 22:40:35 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D709E42F0A;
	Wed,  2 Dec 2009 22:40:34 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7E73D1240011; Wed,  2 Dec 2009 22:40:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vaay1gt0z.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134405>


--6ys2uLYBf50XP5fk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2009 at 09:55:24AM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> I should have mentioned ones with more importance in real-life before
> referring you to the amusing ones: US and European dates.
>=20
> date.c::match_multi_number() groks these:
>=20
>     mm/dd/yy[yy] (US)
>     dd.mm.yy[yy] (European)

As far as I see these are also about approxidate() as well. But thanks
for the ISO number, now I have enough info to add documentation about
it. Patch is coming soon... ;)

--6ys2uLYBf50XP5fk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksW3tIACgkQe81tAgORUJY4HQCgnIXTNBVth4QLDKl+iSY7+O9U
iFgAoKhhYY9gpl0Pbm1PS6CETEPGZW8U
=ni1l
-----END PGP SIGNATURE-----

--6ys2uLYBf50XP5fk--
