From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Tue, 23 Dec 2008 23:35:18 -0500
Message-ID: <43952.1230093318@turing-police.cc.vt.edu>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk> <alpine.DEB.1.00.0812121952320.5873@eeepc-johanness> <20081219000218.GA23990@linux.vnet.ibm.com> <7vabatf1pg.fsf@gitster.siamese.dyndns.org>
            <20081219012723.GI6912@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1230093318_3347P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
X-From: git-owner@vger.kernel.org Wed Dec 24 05:37:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFLVB-0001hr-An
	for gcvg-git-2@gmane.org; Wed, 24 Dec 2008 05:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbYLXEgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 23:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYLXEgR
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 23:36:17 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43427 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbYLXEgR (ORCPT <RFC822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 23:36:17 -0500
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu [127.0.0.1])
	by turing-police.cc.vt.edu (8.14.3/8.14.3) with ESMTP id mBO4ZIBC043956;
	Tue, 23 Dec 2008 23:35:18 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
In-Reply-To: Your message of "Thu, 18 Dec 2008 17:27:23 PST."
             <20081219012723.GI6912@linux.vnet.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103857>

--==_Exmh_1230093318_3347P
Content-Type: text/plain; charset=us-ascii

On Thu, 18 Dec 2008 17:27:23 PST, "Paul E. McKenney" said:

> I would be OK with it being in linux-2.6.git rather than git.git,
> if that helps.  Certainly there seems to be room for a description
> of how to use git within the Linux community.

What might help a lot of people (me, for one) would be a cookbook listing
how to do things that those of us on the fringe might want to do. For example:

"type this to pull Linus's tree, and this to bisect it" (I already know how
to do this one, actually)

"type this to pull a linux-next tree, and this to bisect it" (Last time I tried,
the pull went OK, but I couldn't figure out how to give 'git bisect' a
start/end commit that it was happy with).

"'git log foo/bar/baz.c' is your friend if you're chasing a recently added
bug/regression in baz.c"

Hmm... it occurs to me that my only actual use for git is to find a commit
ID so when I whinge to a developer, we're on the same page... ;)



--==_Exmh_1230093318_3347P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFJUbwGcC3lWbTT17ARAvi+AKCJ86HgkWoEL4cao/90pUu7iw5q+QCgheUr
fxcO+TZCEih0XHc4Qn5TqQk=
=g8eh
-----END PGP SIGNATURE-----

--==_Exmh_1230093318_3347P--
