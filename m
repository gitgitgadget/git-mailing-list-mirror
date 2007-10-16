From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-send-email: add a new sendemail.to configuration
	variable
Date: Tue, 16 Oct 2007 22:05:47 +0200
Message-ID: <20071016200547.GR23810@genesis.frugalware.org>
References: <1191242562-27486-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tH81YkO9bF1TqYxP"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 22:06:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihsfx-0001t7-7E
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 22:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802AbXJPUFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 16:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759319AbXJPUFu
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 16:05:50 -0400
Received: from virgo.iok.hu ([193.202.89.103]:39677 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbXJPUFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 16:05:49 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8B6551B253D
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 22:05:47 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 14CCE44659
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 22:05:38 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 42A2513A4023; Tue, 16 Oct 2007 22:05:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1191242562-27486-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61245>


--tH81YkO9bF1TqYxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 01, 2007 at 02:42:42PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> Several projects prefers to receive patches via a given email address. In these
> cases it's handy to configure that address once.

could somebody please comment this patch? does it look ok?

thanks,
- VMiklos

--tH81YkO9bF1TqYxP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHFRmbe81tAgORUJYRAhfUAJsG9WRPXkLs0zSPk2299wYOGEQckQCgqDyQ
2EG4TnUWQK8inRYuPFO2+m8=
=g2o/
-----END PGP SIGNATURE-----

--tH81YkO9bF1TqYxP--
