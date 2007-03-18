From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sun, 18 Mar 2007 17:25:40 -0400
Message-ID: <20070318212540.GA20658@spearce.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org> <200703181153.59768.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0703181033060.6730@woody.linux-foundation.org> <200703181929.58278.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 22:26:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT2tE-0000Il-3S
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 22:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933215AbXCRV0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Mar 2007 17:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbXCRV0F
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 17:26:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41970 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286AbXCRV0E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2007 17:26:04 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HT2sg-0000IP-Af; Sun, 18 Mar 2007 17:25:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 162B620FBAE; Sun, 18 Mar 2007 17:25:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200703181929.58278.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42523>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> s=F6ndag 18 mars 2007 18:34 skrev Linus Torvalds:
> >=20
> > On Sun, 18 Mar 2007, Robin Rosenberg wrote:
> > >=20
> > > I don't have the KDE repo, but I do have an Eclipse import.=20
> > >=20
> > > The eclipse repo is about 140k commits in the master branch and=20
> > > has a 3GB pack file (fromcvs import).=20
> >=20
> > Do you happen to have a fast internet connection that you can expos=
e this=20
> > thing on?
>=20
> Not that fast and it would take me quite a time to move the files to =
a public
> location (it's on my laptop). I'd rather dump it somewhere directly i=
f someone can
> provide me with some suitable coordinates.

I'd like to get a copy of one of these big repos too (KDE, Eclipse).

I probably could get a DVD onto both Internet and Internet2 from a
fast enough pipe that a few folks (e.g. Linus, Nico, Junio) could
pull it down, but I can't offer a public distribution point for
the world.

--=20
Shawn.
