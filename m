From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Set TAR in t/Makefile and in t4116-apply-reverse.sh
Date: Fri, 25 Jul 2008 19:05:22 +0200
Message-ID: <20080725170522.GG32057@genesis.frugalware.org>
References: <TE3N1FoSy-vEEv0qsAyvBwBMMq2RuJCWYw7DNLBC7mEh6PxM1LCsOw@cipher.nrlssc.navy.mil> <1217003860-10609-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IxlmieUzCzCqf3CN"
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 19:06:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQkK-0008R3-IS
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 19:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbYGYRFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 13:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbYGYRFZ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 13:05:25 -0400
Received: from virgo.iok.hu ([193.202.89.103]:43785 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbYGYRFY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 13:05:24 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 671F01B2504;
	Fri, 25 Jul 2008 19:05:23 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B1E114465E;
	Fri, 25 Jul 2008 18:22:51 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 65FD11190A09; Fri, 25 Jul 2008 19:05:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217003860-10609-1-git-send-email-s-beyer@gmx.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90073>


--IxlmieUzCzCqf3CN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 25, 2008 at 06:37:40PM +0200, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hence, the test passes also when you run "make" in t/
> or when you invoke t4116-apply-reverse.sh directly,
> without $TAR being set.

Thanks, I just hit this issue today. ;-)

--IxlmieUzCzCqf3CN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiKB9IACgkQe81tAgORUJY0qgCfdUkBMSB1nC8Q4/Wi6TYlFFFK
dc4AnjTqjfmGfKt3gQfad18UdlH5ck9m
=wONt
-----END PGP SIGNATURE-----

--IxlmieUzCzCqf3CN--
