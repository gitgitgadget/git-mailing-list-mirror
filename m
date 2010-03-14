From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [RFC] Gitweb: include minified version of js and css files in
 the repo
Date: Sun, 14 Mar 2010 14:22:30 +0100
Message-ID: <20100314132230.GK27414@genesis.frugalware.org>
References: <1B527F20-CF6C-451B-9C6E-1BE74992354D@gmail.com>
 <m3d3z8lj9x.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uqlJfHshKOiOfK6d"
Cc: Mark Rada <markrada26@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 14:22:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqnmC-0005u8-8A
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 14:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758176Ab0CNNWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 09:22:35 -0400
Received: from virgo.iok.hu ([212.40.97.103]:33719 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756350Ab0CNNWe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 09:22:34 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A124C58095;
	Sun, 14 Mar 2010 14:22:30 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6478B42F09;
	Sun, 14 Mar 2010 14:22:30 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9AE5A1240003; Sun, 14 Mar 2010 14:22:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3d3z8lj9x.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142137>


--uqlJfHshKOiOfK6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 13, 2010 at 12:26:51AM -0800, Jakub Narebski <jnareb@gmail.com> wrote:
> The reason is that one should not include *generated* files in
> version control.  We do not include ./configure script (from
> configure.ac), we do not include gitweb.min.js (from gitweb.js).

Though maybe it would be handy to document what a sane default value for
JSMIN could be? (Provided that the user don't set it to empty what the
real default is.)

--uqlJfHshKOiOfK6d
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuc4xYACgkQe81tAgORUJajCgCdH/hTwAopJnzfn9bHpPVOcy2T
adMAn3fqSebnepQMdlGgOHhydF6/ccY9
=BttJ
-----END PGP SIGNATURE-----

--uqlJfHshKOiOfK6d--
