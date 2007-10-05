From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-shell and git-cvsserver
Date: Fri, 5 Oct 2007 16:31:35 +0200
Message-ID: <20071005143135.GO15339@genesis.frugalware.org>
References: <200710051453.47622.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qa0ccP92Gc0Ko3P8"
Cc: Git Mailing List <git@vger.kernel.org>
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Fri Oct 05 16:31:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdoDR-0004RB-Oh
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 16:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154AbXJEObi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 10:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756116AbXJEObh
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 10:31:37 -0400
Received: from virgo.iok.hu ([193.202.89.103]:48229 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172AbXJEObh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 10:31:37 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 83C2E1B2530;
	Fri,  5 Oct 2007 16:31:35 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5ED0F6FD4D;
	Fri,  5 Oct 2007 16:31:35 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 419C413A40EA; Fri,  5 Oct 2007 16:31:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200710051453.47622.wielemak@science.uva.nl>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60086>


--Qa0ccP92Gc0Ko3P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 05, 2007 at 02:53:47PM +0200, Jan Wielemaker <wielemak@science.uva.nl> wrote:
> +#define EXEC_PATH "/usr/local/bin"

why don't you use $(prefix) from the Makefile?

- VMiklos

--Qa0ccP92Gc0Ko3P8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHBkrHe81tAgORUJYRAmUqAJ9N45wcHx6yedJpIfHb8G4r2IMyLACglMVo
2URk5GAhzqGo8EB1h2o6wzo=
=IObx
-----END PGP SIGNATURE-----

--Qa0ccP92Gc0Ko3P8--
