From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: 'error: unable to set permission to './objects/...'
Date: Sun, 22 Nov 2009 23:09:00 +0100
Message-ID: <20091122220900.GO23718@genesis.frugalware.org>
References: <9bbf67fa0911221202r605de38coc2496b1f09123725@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bLgs+aUf1UT65bBm"
Cc: git@vger.kernel.org
To: Rafal Rusin <rafal.rusin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 23:09:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCKcF-0005Gu-Ob
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 23:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbZKVWI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 17:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbZKVWI4
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 17:08:56 -0500
Received: from virgo.iok.hu ([212.40.97.103]:49917 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380AbZKVWIz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 17:08:55 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id AA04658098;
	Sun, 22 Nov 2009 23:09:00 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7198644951;
	Sun, 22 Nov 2009 23:09:00 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 616BA1240012; Sun, 22 Nov 2009 23:09:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9bbf67fa0911221202r605de38coc2496b1f09123725@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133457>


--bLgs+aUf1UT65bBm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 22, 2009 at 09:02:12PM +0100, Rafal Rusin <rafal.rusin@gmail.com> wrote:
> I did a small fix to sha1_file.c (patch in attachment) and git now
> warns when unable to chmod, and continues push. This resolved problem.
> What do you think about applying it?

Please read Documentation/SubmittingPatches, patches should be sent
inline and with a Signed-off-by line.

--bLgs+aUf1UT65bBm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksJtnwACgkQe81tAgORUJaAmQCfZI/BUVMCSmRwOh+DelA29EnF
+OUAoJH9DdzEOW69LYGUcXY270cu6nco
=2s1I
-----END PGP SIGNATURE-----

--bLgs+aUf1UT65bBm--
