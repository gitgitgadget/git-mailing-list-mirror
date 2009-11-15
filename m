From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Check the format of more printf-type functions
Date: Sun, 15 Nov 2009 02:10:44 +0100
Message-ID: <20091115011044.GL23718@genesis.frugalware.org>
References: <1258234393-5093-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AaroDtM9M79Ffl67"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 02:10:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9Tdl-00024Q-EJ
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 02:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbZKOBKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 20:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbZKOBKk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 20:10:40 -0500
Received: from virgo.iok.hu ([212.40.97.103]:43837 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313AbZKOBKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 20:10:40 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E3667580D4;
	Sun, 15 Nov 2009 02:10:44 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9B52244953;
	Sun, 15 Nov 2009 02:10:44 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7E0141240011; Sun, 15 Nov 2009 02:10:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258234393-5093-1-git-send-email-tarmigan+git@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132903>


--AaroDtM9M79Ffl67
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 14, 2009 at 01:33:13PM -0800, Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
> it for others to make a proper fix.  Looks like Miklos touched that line
> last, so perhaps he knows of a better fix.

I just added struct merge_options, the real change is commit a97e407
(Keep rename/rename conflicts of intermediate merges while doing
recursive merge, 2007-03-31), adding Alex to Cc.

--AaroDtM9M79Ffl67
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkr/VRQACgkQe81tAgORUJbjHQCgmhnhwDDL0uPkwPuJvWKcnVs+
H4UAn1Q9VkSlSis+mEwWAf1CCE/jfghB
=+5S0
-----END PGP SIGNATURE-----

--AaroDtM9M79Ffl67--
