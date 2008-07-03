From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [RFC/PATCH 7/7] Documentation formatting and cleanup
Date: Wed, 2 Jul 2008 21:28:17 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807022110460.10323@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <Pine.GSO.4.62.0806301730230.7190@harper.uchicago.edu> <486A2C8C.5050204@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1215052097=:10323"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jon Loeliger <jdl@jdl.com>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7e-0002yW-Fz
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbYGCG7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbYGCG5g
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:36 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:43568 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbYGCC2u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 22:28:50 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m632SKjD011225;
	Wed, 2 Jul 2008 21:28:20 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m632SIij012788;
	Wed, 2 Jul 2008 21:28:18 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <486A2C8C.5050204@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87245>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-851401618-1215052097=:10323
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Olivier Marin wrote:

> Jonathan Nieder a =E9crit :
> > [184 KB patch online at
> > <http://home.uchicago.edu/~jrnieder/20080701-git-doc-style.txt>]
>=20
> You did a lot of:
>=20
> > -replaced; you need to use a tool such as linkgit:git-diff[1] or the "p=
ickaxe"
> > +replaced; you need to use a tool such as `git-diff` or the "pickaxe"
>=20
> Are those kind of changes really an improvement?

I should have also added

=09SEE ALSO
=09--------

=09linkgit:git-diff[1], ...

but I was trying to keep my changes minimal.  I'll send some suggestions
for see also sections ome time this week; I haven't found time to prune
down the lists of cross references I have in my tree now.  Thanks for
the reminder.

Jonathan
---559023410-851401618-1215052097=:10323--
