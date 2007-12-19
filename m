From: Miklos Vajna <vmiklos@frugalware.org>
Subject: more than 20 commands in everyday.txt
Date: Wed, 19 Dec 2007 23:56:18 +0100
Message-ID: <20071219225618.GA7378@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 23:56:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J57qJ-0000TP-Hs
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 23:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbXLSW4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 17:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbXLSW4U
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 17:56:20 -0500
Received: from virgo.iok.hu ([193.202.89.103]:16135 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbXLSW4T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 17:56:19 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A95911B24FB
	for <git@vger.kernel.org>; Wed, 19 Dec 2007 23:56:18 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 50D6A4465C
	for <git@vger.kernel.org>; Wed, 19 Dec 2007 23:55:00 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5B198119019C; Wed, 19 Dec 2007 23:56:18 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68951>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

this might seem to be a bit bikesheding, but i hope it isn't. today i
teched git to someone who never used any scm so far. i showed him the
"everyday with git" document, as i think it's a great start for newbies.
actually i read it once but it was in the past, now i did it again and i
think there are some commands listed there which is not something we use
"every day". of course it may be only me, that's why i ask. here are the
commands i rarely use and are in everyday.txt:

- git-prune and git-repack: usually i use git-gc only. maybe prune and
  repack could be removed from everyday.txt?

- git-show-branch: what about mentioning gitk instead? i think it's much
  more used - compared to git-show-branch

what do you think about this? maybe i'm wrong, but if i'm right, then i
would provide a patch to update everyday.txt according to these
suggestions.

thanks,
- VMiklos

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHaaGSe81tAgORUJYRAunTAJ9mebelZTRtoxLXZFg+t64IvxAUuQCcCNEq
7JI5op8lh5HzQ0dX1mUgZHY=
=ybDQ
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
