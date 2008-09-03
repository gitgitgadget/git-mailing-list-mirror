From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: blame vs annotate?
Date: Wed, 3 Sep 2008 19:49:39 +0200
Message-ID: <20080903174939.GH16514@genesis.frugalware.org>
References: <57518fd10809030943i35af222fw82cf591c737b8c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8i0lXXx49qphuFT"
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:51:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KawVG-0001xY-7g
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758840AbYICRto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758835AbYICRtn
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:49:43 -0400
Received: from virgo.iok.hu ([193.202.89.103]:55170 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758830AbYICRtl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:49:41 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2BF321B251A;
	Wed,  3 Sep 2008 19:49:40 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E7BE44465E;
	Wed,  3 Sep 2008 19:49:39 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 99A6E1190009; Wed,  3 Sep 2008 19:49:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <57518fd10809030943i35af222fw82cf591c737b8c04@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94826>


--a8i0lXXx49qphuFT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2008 at 05:43:03PM +0100, Jonathan del Strother <maillist@steelskies.com> wrote:
> What's the difference between 'git blame' & 'git annotate'?  The
> output is practically identical - it's not obvious when you would use
> one over the other

'git annoate' is the same as 'git blame -c'.

--a8i0lXXx49qphuFT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki+zjMACgkQe81tAgORUJY5OwCdH2IGtFloCri6sEG0UU4a5fz7
ll8An072e0ppOSgCUPfn2U5y3v52KxP2
=zPbf
-----END PGP SIGNATURE-----

--a8i0lXXx49qphuFT--
