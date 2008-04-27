From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-send-email: add a new sendemail.cc configuration
	variable
Date: Mon, 28 Apr 2008 00:42:55 +0200
Message-ID: <20080427224255.GD31919@genesis.frugalware.org>
References: <1209244746-12649-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0804262330370.7944@eeepc-johanness> <20080426232737.GR4012@genesis.frugalware.org> <alpine.DEB.1.00.0804271252200.16320@eeepc-johanness> <20080427121458.GU4012@genesis.frugalware.org> <7vprsbf3hz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 00:43:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqFb0-00011B-DS
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 00:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbYD0Wm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 18:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbYD0Wm6
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 18:42:58 -0400
Received: from virgo.iok.hu ([193.202.89.103]:49759 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbYD0Wm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 18:42:57 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B0D491B2520;
	Mon, 28 Apr 2008 00:42:55 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 347C244659;
	Mon, 28 Apr 2008 00:39:16 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 522561190AC9; Mon, 28 Apr 2008 00:42:55 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vprsbf3hz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80491>


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2008 at 01:26:48PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> Thanks, the idea makes sense.
>=20
> Tests?

As far as I see, none of the sendemail.* configuration variables have
tests. Should I add a test for each of them?

Also, what is the preferred way of the testing method in this case?
Should I just rely on a --dry-run output?

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkgVAW8ACgkQe81tAgORUJaVEQCgidMp8sYTRjOS8C6YfO4s1t6I
isQAnRdH6p+zZ9F3GU1CoskLm068VHIx
=6HoO
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
