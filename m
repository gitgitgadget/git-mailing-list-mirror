From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Fri, 29 Aug 2008 12:24:20 -0400
Message-ID: <20080829162420.GB20629@yugib.highrise.ca>
References: <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu> <20080828215907.GE27867@coredump.intra.peff.net> <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu> <881C17DA-2FE2-49A7-A4A9-FACA7720599C@cs.indiana.edu> <20080829152451.GA20629@yugib.highrise.ca> <94a0d4530808290911j32bf5ee0q869dfe39483297f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 18:25:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ6mt-00060c-Rr
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 18:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756806AbYH2QYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 12:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756754AbYH2QYW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 12:24:22 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:38678 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbYH2QYV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 12:24:21 -0400
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id A1651111E39;
	Fri, 29 Aug 2008 12:24:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <94a0d4530808290911j32bf5ee0q869dfe39483297f8@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94309>


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Felipe Contreras <felipe.contreras@gmail.com> [080829 12:11]:
> On Fri, Aug 29, 2008 at 6:24 PM, Aidan Van Dyk <aidan@highrise.ca> wrote:
> > * Perry Wagle <wagle@cs.indiana.edu> [080801 00:00]:
> >> Jeff King has convinced me that it's perfectly legitimate to introduce
> >> non-upward compatibilities in minor version releases of "young"
> >> software.
> >
> > This is the gist of the problem.  You keep hammering about a
> > "non-upwards compatibilities in minor version releases", yet you have
> > *not* pointed out one such in-compatibility in a minor version release..
> >
> > Remember, in git, 1.6 is a "major version" release, with release notes, etc.
> > 1.5.X is a "minor version" release.
> > 1.5.X.Y is a "patch" release.
> 
> What is X (2.0)?

X would be a digit, like 0, 1, 2, 3, 4, 5, 6, 7, 8, or 9, as in the git
1.5 releases:
	1.5.0
	1.5.1
	1.5.2
	1.5.3
	1.5.4
	1.5.4
	1.5.6

And now also:
	1.6.0, being the first of the 1.6 releases...

a.
-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFIuCK0uVxNPsxNPScRAm/tAJ984CWsH72b/TEQbrWBj/xzL9q54QCePXyW
oA6MDzqmod1HzxDHCz0j0A4=
=CVPf
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
