From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Tue, 25 Nov 2008 21:41:08 +0100
Message-ID: <20081125204108.GF4746@genesis.frugalware.org>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com> <492C367D.3030209@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIwHDYD8sUXtBKvt"
Cc: Ondrej Certik <ondrej@certik.cz>,
	Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 25 21:58:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L54yh-0006dX-GX
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 21:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbYKYU4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 15:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYKYU4b
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 15:56:31 -0500
Received: from virgo.iok.hu ([212.40.97.103]:36878 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbYKYU4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 15:56:31 -0500
X-Greylist: delayed 919 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Nov 2008 15:56:30 EST
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 181C65809B;
	Tue, 25 Nov 2008 21:41:09 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6101D4465E;
	Tue, 25 Nov 2008 21:41:08 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3EB6A11901A1; Tue, 25 Nov 2008 21:41:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <492C367D.3030209@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101681>


--YIwHDYD8sUXtBKvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2008 at 06:31:41PM +0100, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> I don't know, I just noticed that turning on rename and copy detection
> makes git-fast-import crash, which shouldn't happen either. Something's
> not right here. CC'ing the authors of im- and export.

Could you please write a testcase that reproduces your problem?

> Why export|import directly to git?

I guess he did not know about filter-branch. :)

--YIwHDYD8sUXtBKvt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkksYuQACgkQe81tAgORUJYYwgCeNWAJ6MIcBXWGTCqW1HrV74kW
UCgAniev+k56x+7PJu2CEhsFUxppOfmh
=yglj
-----END PGP SIGNATURE-----

--YIwHDYD8sUXtBKvt--
