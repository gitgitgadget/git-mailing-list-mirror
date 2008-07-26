From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] t7601: extend the 'merge picks up the best result' test
Date: Sat, 26 Jul 2008 14:33:45 +0200
Message-ID: <20080726123345.GH32057@genesis.frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org> <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org> <1217073292-27945-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aWh+LmBTmEUMKd3g"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 14:34:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMiz4-0004OM-02
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 14:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbYGZMdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 08:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbYGZMdu
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 08:33:50 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47323 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815AbYGZMdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 08:33:49 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 3CBA91B24FC
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 14:33:48 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8717A4465E
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 13:50:47 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id EEED71190A09; Sat, 26 Jul 2008 14:33:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217073292-27945-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90220>


--aWh+LmBTmEUMKd3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 26, 2008 at 01:54:45PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> The test only checked if the best result picking code works if there are
> multiple strategies set in the config. Add a similar one that tests if
> the same true if the -s option of git merge was used multiple times.

Ignore this one. I run git send-email *.patch when sending out the other
series and forgot to do an rm *.patch before format-patch.

Sorry,
Miklos

--aWh+LmBTmEUMKd3g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiLGakACgkQe81tAgORUJZowACfU451B43Ty3vrBl685GJGDWNl
jzEAn1TwfKLniU8XmC8NZ2axclFl5UEG
=Pj23
-----END PGP SIGNATURE-----

--aWh+LmBTmEUMKd3g--
