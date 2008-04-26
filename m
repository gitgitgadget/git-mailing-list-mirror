From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-format-patch: add a new format.cc configuration
	variable
Date: Sun, 27 Apr 2008 01:27:37 +0200
Message-ID: <20080426232737.GR4012@genesis.frugalware.org>
References: <1209244746-12649-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0804262330370.7944@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CFO0SFgG+t1lcV5s"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 27 01:28:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jptot-0001ZV-4b
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 01:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbYDZX1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 19:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbYDZX1o
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 19:27:44 -0400
Received: from virgo.iok.hu ([193.202.89.103]:45505 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521AbYDZX1o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 19:27:44 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C42FF1B25A1;
	Sun, 27 Apr 2008 01:27:40 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3684C44659;
	Sun, 27 Apr 2008 01:24:00 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 222B311904D3; Sun, 27 Apr 2008 01:27:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804262330370.7944@eeepc-johanness>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80398>


--CFO0SFgG+t1lcV5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2008 at 11:31:13PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> I am wary... should this not be specific to send-email?  IOW should=20
> format-patch not be left alone?

Yes and no. :-) I first searched for a --cc option in send-email, then
realized that only format-patch has one. So I made it configurable,
instead of adding a new option to send-email for the very same purpose
format-patch already has an option. But I may be wrong.

--CFO0SFgG+t1lcV5s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkgTumkACgkQe81tAgORUJZClgCfWfFvyKoAZoOfCirTh2+LVUrF
DxsAn0Vib+QQZ33nKski1VWFFQwbabcL
=mLjM
-----END PGP SIGNATURE-----

--CFO0SFgG+t1lcV5s--
