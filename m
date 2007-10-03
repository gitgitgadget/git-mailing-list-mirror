From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Mention 'cpio' dependency in INSTALL
Date: Wed, 3 Oct 2007 09:40:07 +0200
Message-ID: <20071003074007.GA15339@genesis.frugalware.org>
References: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com> <200710012342.37352.johan@herland.net> <3f4fd2640710021409q104a4204r522391912d5b5c8c@mail.gmail.com> <200710030142.30062.johan@herland.net> <7v1wcdjbq6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Reece Dunn <msclrhd@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 09:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcyqK-0002XH-27
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 09:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416AbXJCHkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 03:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756320AbXJCHkO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 03:40:14 -0400
Received: from virgo.iok.hu ([193.202.89.103]:43375 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756170AbXJCHkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 03:40:12 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id CF64D1B2511;
	Wed,  3 Oct 2007 09:40:10 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 59E856FD40;
	Wed,  3 Oct 2007 09:40:08 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 87BFC13A4077; Wed,  3 Oct 2007 09:40:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1wcdjbq6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59802>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 02, 2007 at 05:14:25PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Are there other commands we rely on that may not be universally
> installed?  I myself consider "cut" to be in the category, but
> other than that I do not think of anything offhand.

when using git in a chroot, i obviously had coreutils/sed/grep installed
and the only "extra" package i needed (besides the curl an openssl libs)
was cpio

- VMiklos

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHA0dXe81tAgORUJYRAiPVAJ0ZO4B3QYM9pqZRMiLr3CfJbzpGAwCfTnYL
EWCt4kRAEPI1envDRxvwUdA=
=CIWV
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
