From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 0/m] Implementation of a file tree iteration using ignore rules.
Date: Sat, 10 May 2008 20:16:12 -0400
Message-ID: <20080511001612.GJ29038@spearce.org>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de> <200805102245.08295.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun May 11 02:17:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuzFQ-0001jt-KK
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 02:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbYEKAQQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 May 2008 20:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbYEKAQQ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 20:16:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35441 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbYEKAQP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2008 20:16:15 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JuzER-0002W3-IC; Sat, 10 May 2008 20:16:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6735720FBAE; Sat, 10 May 2008 20:16:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200805102245.08295.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81720>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> l=C3=B6rdagen den 10 maj 2008 15.00.18 skrev Florian Koeberle:
> >=20
> Welcome to the project Florian!
>=20
> > here are the patches.
> >=20
> > The implementation does a lot of performance optimizations:
>=20
> [...], not trying to be too picky and requiring
> you to think of everyhing I don't. We always play rough with newcomer=
s :)

Not just newcomers, we play rough with everyone!  :-)

Personally, I love this environment.  Because of how tough everyone
is on each other's patches I've learned more in the past few years
here working on Git than I have learned in 4x that amount of time
working elsewhere.

--=20
Shawn.
