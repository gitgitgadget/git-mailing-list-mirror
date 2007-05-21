From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Commit ID in exported Tar Ball
Date: Mon, 21 May 2007 09:00:42 +0200
Message-ID: <20070521070042.GE23350@cip.informatik.uni-erlangen.de>
References: <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <20070520161048.GI5015@cip.informatik.uni-erlangen.de> <817CD103-261C-4D40-9C8F-00B2E14130BE@silverinsanity.com> <20070520163026.GA7387@cip.informatik.uni-erlangen.de> <20070521062953.GL3141@spearce.org> <20070521063752.GB23350@cip.informatik.uni-erlangen.de> <20070521065355.GN3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Junio C Hamano <junkio@cox.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 21 09:00:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq1sv-0003A6-EL
	for gcvg-git@gmane.org; Mon, 21 May 2007 09:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbXEUHAo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 03:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbXEUHAn
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 03:00:43 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:38949 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754528AbXEUHAn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2007 03:00:43 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 1F0943F30C; Mon, 21 May 2007 09:00:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070521065355.GN3141@spearce.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47978>

Hello,

> So what, a magic flag to git-describe like:

> 	git-describe --untagged HEAD
> 	1a8213...

> Where --untagged just means "give me back the raw commit SHA-1 if
> the input ref(s) aren't tagged"?

that is something I would love to live with. But it should also get the
primary objective done which is: Get the commit-id in the tar archive.

        Thomas
