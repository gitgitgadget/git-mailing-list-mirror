From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (Dec 2008, #04; Mon, 29)
Date: Wed, 31 Dec 2008 01:10:36 +0100
Message-ID: <20081231001036.GW21154@genesis.frugalware.org>
References: <7vocyt1is2.fsf@gitster.siamese.dyndns.org> <m3fxk5b6di.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MXXylufPoVaQ01lt"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 01:12:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHogy-0003Td-FD
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 01:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbYLaAKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 19:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbYLaAKm
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 19:10:42 -0500
Received: from virgo.iok.hu ([212.40.97.103]:38054 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbYLaAKl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 19:10:41 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 12B2C580D0;
	Wed, 31 Dec 2008 01:10:39 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A010A4465E;
	Wed, 31 Dec 2008 01:10:36 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 6294F11B8630; Wed, 31 Dec 2008 01:10:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3fxk5b6di.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104229>


--MXXylufPoVaQ01lt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 30, 2008 at 03:15:43PM -0800, Jakub Narebski <jnareb@gmail.com> wrote:
> P.S. BTW. what is the status on using parse_options among git
> commands?

You mean the C or the shell commands?

I sent the third version of the builtin-apply migration ($gmane/104029),
but I got no answer so far, probably it was dropped on the floor by
accident. ;-)

--MXXylufPoVaQ01lt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklauHwACgkQe81tAgORUJbDpwCfT4jZpodLS9Y/zgDhH0HXO59e
2cUAoIaHZC5E6r8Z6tDyKRBH7QSzH01e
=cGYk
-----END PGP SIGNATURE-----

--MXXylufPoVaQ01lt--
