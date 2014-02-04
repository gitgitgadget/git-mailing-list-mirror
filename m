From: Miklos Vajna <vmiklos@collabora.co.uk>
Subject: Re: git log history simplification problem
Date: Tue, 4 Feb 2014 21:07:04 +0100
Message-ID: <20140204200703.GE17861@collabora.co.uk>
References: <20140204173713.GC17861@collabora.co.uk>
 <20140204194842.GM30398@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 21:01:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAmBo-0003Uj-Ih
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 21:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbaBDUBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 15:01:45 -0500
Received: from bhuna.collabora.co.uk ([93.93.135.160]:34509 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbaBDUBo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 15:01:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: vmiklos)
	with ESMTPSA id 6215B608CAA
Content-Disposition: inline
In-Reply-To: <20140204194842.GM30398@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241544>


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Jonathan,

On Tue, Feb 04, 2014 at 11:48:42AM -0800, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Luckily '-m -p' without --first-parent worked and the first commit it
> showed was the right one.  It produces more hits than I'd like, too,
> though.

Ah, excellent! :-) '-m' does what I need.

Thanks a lot,

Miklos

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLxSGcACgkQe81tAgORUJb+CACgpv24wGTC6wik1DnNk8khLqve
km8An1ng5Y9ygzrpxGzo2XSyU1bzo5sC
=qsE0
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
