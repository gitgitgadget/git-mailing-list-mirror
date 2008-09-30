From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH v2] Add OS X support to the pre-auto-gc example hook
Date: Tue, 30 Sep 2008 17:00:36 +0200
Message-ID: <20080930150036.GB23137@genesis.frugalware.org>
References: <57518fd10809270253s4c07318bjd54c7d86460ce7d7@mail.gmail.com> <1222731388-833-1-git-send-email-jon.delStrother@bestbefore.tv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9b/uWrIH8C2V3aH3"
Cc: git@vger.kernel.org
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Tue Sep 30 17:04:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkgjV-0006Ii-NM
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 17:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbYI3PAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 11:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbYI3PAj
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 11:00:39 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47160 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbYI3PAi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 11:00:38 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4A9D958160;
	Tue, 30 Sep 2008 17:00:37 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 017594465E;
	Tue, 30 Sep 2008 17:00:36 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CCCAF11901A1; Tue, 30 Sep 2008 17:00:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1222731388-833-1-git-send-email-jon.delStrother@bestbefore.tv>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97124>


--9b/uWrIH8C2V3aH3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 30, 2008 at 12:36:28AM +0100, Jonathan del Strother <jon.delStrother@bestbefore.tv> wrote:
> Second attempt - this simplifies the test while making it more
> specific (it will only pack when on AC power, rather than, say, UPS).

Acked-by: Miklos Vajna <vmiklos@frugalware.org>

Thanks.

--9b/uWrIH8C2V3aH3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjiPxQACgkQe81tAgORUJbj/QCfQlyiyWGgT8Jtj6yqAvycHeZj
yNQAn2lGhwRSts+CDJxIN9EjVHUgNL1j
=OBFN
-----END PGP SIGNATURE-----

--9b/uWrIH8C2V3aH3--
