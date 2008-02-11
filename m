From: Sebastian Harl <sh@tokkee.org>
Subject: Re: [Feature Request] Better Subversion integration
Date: Mon, 11 Feb 2008 23:11:57 +0100
Message-ID: <20080211221157.GF20741@albany.tokkee.org>
References: <FC5B6F22-27A9-4F0F-85EE-0B72B94C69E2@gmail.com> <20080210035611.GA2454@atjola.homenet> <20080211084704.GB20741@albany.tokkee.org> <E947A49F-4A4C-43F5-8E22-FFAF008E0B82@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rtWt6SZ6GqpxALBD"
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Git Users List <git@vger.kernel.org>
To: Sam Granieri Jr <sjgdev@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 23:12:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOgt5-0002yV-0m
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 23:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758473AbYBKWMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 17:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757830AbYBKWL7
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 17:11:59 -0500
Received: from mail.tokkee.org ([212.114.247.92]:39591 "EHLO albany.tokkee.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757861AbYBKWL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 17:11:58 -0500
Received: by albany.tokkee.org (Postfix, from userid 1000)
	id CE0F8364001; Mon, 11 Feb 2008 23:11:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <E947A49F-4A4C-43F5-8E22-FFAF008E0B82@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73595>


--rtWt6SZ6GqpxALBD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Mon, Feb 11, 2008 at 10:55:37AM -0600, Sam Granieri Jr wrote:
> If a person wants to work on a tag branch, would the right idea be to =20
> create new branch on it as to not screw up the previous tag?

Why would you want to do that? A tag is supposed to be something
immutable. The only reason for having such a "tag branch" in the first
place is that this seems to be the best representation of what SVN is
doing and there's no better way (yet?) to convert it to something more
Git-like...

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl +++ GnuPG-ID: 0x8501C7FC +++ http://tokkee.org/

Those who would give up Essential Liberty to purchase a little Temporary
Safety, deserve neither Liberty nor Safety.         -- Benjamin Franklin


--rtWt6SZ6GqpxALBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHsMgtEFEKc4UBx/wRArN+AJ9nk+ziGMqsWCeJBMHfRm2hA0I0JQCfWkfZ
sdNs/pQf2CGCHjstNF0MJXw=
=/mJD
-----END PGP SIGNATURE-----

--rtWt6SZ6GqpxALBD--
