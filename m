From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Documentation: mention how to define multiple
	strategies
Date: Fri, 16 May 2008 02:18:02 +0200
Message-ID: <20080516001802.GS27724@genesis.frugalware.org>
References: <1210889417-21370-1-git-send-email-vmiklos@frugalware.org> <7vfxsjf7zy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gzJEy4voKlV4eANz"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 02:19:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwnex-0001NE-Po
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 02:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663AbYEPASH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 20:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbYEPASG
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 20:18:06 -0400
Received: from virgo.iok.hu ([193.202.89.103]:35911 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663AbYEPASE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 20:18:04 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E455F1B254F;
	Fri, 16 May 2008 02:18:02 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id F41314465E;
	Fri, 16 May 2008 02:08:31 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8C13E1770014; Fri, 16 May 2008 02:18:02 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vfxsjf7zy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82248>


--gzJEy4voKlV4eANz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2008 at 04:44:01PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> It indeed is supported to give multiple strategies and let "git merge" try
> each of them.
>=20
> However, I have a very strong doubt if it is really worth keeping the
> support, let alone advertising it.
>=20
> Really.  It was a fun experiment while it was being invented, but I never
> saw any practical usefulness with it.

As a general rule, I try to change nothing while working on
builtin-merge. Should I drop support for it (making an exception here),
or will you accept tests for this, just you would like to exclude it
=66rom documentation?

Thanks.

--gzJEy4voKlV4eANz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkgs0roACgkQe81tAgORUJbjggCfRIBwdGHoVDE15/mbfwZW/3v6
a4wAnREoNoV4e717XEqWRvcOsP36mN8g
=CuDb
-----END PGP SIGNATURE-----

--gzJEy4voKlV4eANz--
