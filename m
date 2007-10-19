From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Thu, 18 Oct 2007 22:49:39 -0400
Message-ID: <20071019024939.GC14735@spearce.org>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org> <85ve98gl57.fsf@lola.goethe.zz> <alpine.LFD.0.999.0710171553580.26902@woody.linux-foundation.org> <200710190449.49477.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Kastrup <dak@gnu.org>, Geert Bosch <bosch@adacore.com>,
	David Symonds <dsymonds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Marius Storm-Olsen <marius@trolltech.com>,
	Ren? Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:50:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihwM-0003zE-4Q
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965625AbXJSCt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 22:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965577AbXJSCt6
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:49:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43896 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965534AbXJSCt5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 22:49:57 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IihvR-0000fB-6G; Thu, 18 Oct 2007 22:49:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2A80B20FBAE; Thu, 18 Oct 2007 22:49:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200710190449.49477.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61617>

Christian Couder <chriscool@tuxfamily.org> wrote:
> Le jeudi 18 octobre 2007, Linus Torvalds a =C3=A9crit :
> > Well, this has been debated to death, but I actually think that "sk=
ip" is
> > a good choice, exactly because it's an action.
>=20
> I will happily provide a new patch series with "skip" instead of "dun=
no"=20
> if/when Shawn says that the discussion is over.

I had concluded yesterday that this discussion is likely over and
that skip is the term we all were OK with.  But unfortunately you
just found out that vger is unable to read my mind and send such
an email to the mailing list.  :-)

Please make it so.

--=20
Shawn.
