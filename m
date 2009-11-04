From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH 0/2] Set Makefile variables from configure
Date: Wed, 04 Nov 2009 13:07:17 -0500
Message-ID: <1257357992-sup-8444@ntdws12.chass.utoronto.ca>
References: <1257021695-21260-1-git-send-email-bwalton@artsci.utoronto.ca> <20091103222123.GA17097@progeny.tock>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1257358042-298240-21017-7418-22-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
Cc: gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 19:07:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5kGZ-0007XO-09
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 19:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbZKDSHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 13:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbZKDSHS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 13:07:18 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:49402 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbZKDSHR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 13:07:17 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:59413 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N5kGQ-0001RW-FB; Wed, 04 Nov 2009 13:07:22 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N5kGQ-0003L6-Bi; Wed, 04 Nov 2009 13:07:22 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id nA4I7M4t012836;
	Wed, 4 Nov 2009 13:07:22 -0500
In-reply-to: <20091103222123.GA17097@progeny.tock>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132108>


--=-1257358042-298240-21017-7418-22-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Jonathan Nieder's message of Tue Nov 03 17:21:23 -0500 2009:

> Would the --sysconfdir option work for you here?  Setting --sysconfdir
> currently does nothing, so the question is kind of moot without some
> change like this (untested):

I think this is a generally useful patch.

Thanks
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1257358042-298240-21017-7418-22-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFK8cLa8vuMHY6J9tIRAjCnAKDVGR7OFe1UmmyCrwxyduGZc53KVgCdHY/U
T3J4Ws6J04YEu4kitHgqjns=
=W6yj
-----END PGP SIGNATURE-----

--=-1257358042-298240-21017-7418-22-=--
