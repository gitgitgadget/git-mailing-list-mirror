From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: Any git-1.6.0+ RPMs for el5?
Date: Fri, 24 Apr 2009 19:26:34 -0400
Message-ID: <1240615270-sup-5080@ntdws12.chass.utoronto.ca>
References: <gstcu6$tdf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1240615598-738193-31250-3622-8-="; micalg="pgp-sha1"
Cc: GIT List <git@vger.kernel.org>
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:28:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUoa-0001Q3-EK
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbZDXX0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756004AbZDXX0l
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:26:41 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:33158 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbZDXX0k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:26:40 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:42717 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1LxUn2-0005p8-0W; Fri, 24 Apr 2009 19:26:40 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1LxUn0-0000x0-Tu; Fri, 24 Apr 2009 19:26:39 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n3ONQc1X003654;
	Fri, 24 Apr 2009 19:26:38 -0400
In-Reply-To: <gstcu6$tdf$1@ger.gmane.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117520>


--=-1240615598-738193-31250-3622-8-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Neal Kreitzinger's message of Fri Apr 24 18:05:23 -0400 2009:
> Are there any EL5 RPMs available for Git 1.6.0 or greater?    The current 
> EL5 repo rpm for git-1.5.5.6 is apparently relatively outdated in the git 
> timeline.  My team is new to git and to linux and are hoping to learn the 
> newer version of git without having to first ascend the learning curve of 
> compiling git.  We are hoping that other el5 git users before us have 
> created git 1.6.0+ rpms for their own use.  Is it correct to assume that an 
> el5 rpm created by someone else can also be installed on our RHEL 5.2+ box?

I can offer you my local builds of 1.6.1.2 for rhel5 if you're
interested.  These are stock as I used the .spec file as distributed
with the source to do the build.

They're now available here:
http://www.cquest.utoronto.ca/u/bwalton/git/

HTH.
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1240615598-738193-31250-3622-8-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJ8kqu8vuMHY6J9tIRAqEoAJ0e960JdkXcXNdbRL75qf5Pad5RsACg0gJC
ozlxj/KxBoNaQlk/XLwAF6k=
=UveR
-----END PGP SIGNATURE-----

--=-1240615598-738193-31250-3622-8-=--
