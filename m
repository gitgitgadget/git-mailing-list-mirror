From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-clean: make "Would remove ..." path relative to
	cwd again
Date: Fri, 4 Jan 2008 16:41:06 +0100
Message-ID: <20080104154106.GP29972@genesis.frugalware.org>
References: <7vmyrmmc21.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8m/hfNLtAhX2NvnO"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 16:41:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAofz-00089U-AT
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 16:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbYADPlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 10:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbYADPlK
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 10:41:10 -0500
Received: from virgo.iok.hu ([193.202.89.103]:43772 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbYADPlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 10:41:09 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id CA6CD1B2538;
	Fri,  4 Jan 2008 16:41:06 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1385D4466C;
	Fri,  4 Jan 2008 16:39:31 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4137511904E0; Fri,  4 Jan 2008 16:41:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vmyrmmc21.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69577>


--8m/hfNLtAhX2NvnO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 03, 2008 at 08:47:50PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> The rewrite changed the output to use the path relative to the
> top of the work tree without a good reason.  This fixes it.

works here fine.

thanks,
- VMiklos

--8m/hfNLtAhX2NvnO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHflOSe81tAgORUJYRAiTnAJ90dp7EjBPsjpBAHDVlB5LjEvwMBgCcCBps
LzhuHzURX5ba8yKC2KXnGrw=
=HrWN
-----END PGP SIGNATURE-----

--8m/hfNLtAhX2NvnO--
