From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: [Fwd: [ANNOUNCE] bzr-fastimport plugin, yet another Bazaar import option]
Date: Fri, 22 Feb 2008 14:25:02 -0500
Message-ID: <20080222192502.GB10411@yugib.highrise.ca>
References: <47BE167A.4060005@internode.on.net> <20080222073228.GF8410@spearce.org> <20080222113737.GA18581@artemis.madism.org> <20080222144415.GA19974@yugib.highrise.ca> <20080222182041.GB4555@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ian Clatworthy <ian.clatworthy@internode.on.net>,
	Bazaar <bazaar@lists.canonical.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 20:28:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSdX2-0002P1-68
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 20:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761156AbYBVTZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 14:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760455AbYBVTZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 14:25:09 -0500
Received: from yugib.highrise.ca ([205.150.199.213]:49589 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760891AbYBVTZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 14:25:07 -0500
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 4E328111E3A;
	Fri, 22 Feb 2008 14:25:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080222182041.GB4555@artemis.madism.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74752>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Pierre Habouzit <madcoder@debian.org> [080222 13:40]:
 
>   Well, last time I tried, it exploded miserably (big fat OOM) because
> glibc CVS repository comes back to 1984 or so, and has a very nasty big
> fat Changelog with literally thousands of modifications.

<me run="prepare to">
	When importing a repository like that wouldn't it make sense to nuke
	the redundant ChangeLog,v?
</me run="far away">


-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFHvyGOuVxNPsxNPScRAsGXAJ9LepjS+NFogLVyoHp6l0/Mb/wakACgkRm6
tMaAS1s0StGHuM6aBfEJlK4=
=OkEY
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
