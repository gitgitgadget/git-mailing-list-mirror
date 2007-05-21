From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Commit ID in exported Tar Ball
Date: Mon, 21 May 2007 08:24:06 +0200
Message-ID: <20070521062406.GA23350@cip.informatik.uni-erlangen.de>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <20070520161048.GI5015@cip.informatik.uni-erlangen.de> <817CD103-261C-4D40-9C8F-00B2E14130BE@silverinsanity.com> <20070520163026.GA7387@cip.informatik.uni-erlangen.de> <20070521061954.GB8605@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Brian Gernhardt <benji@silverinsanity.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Mon May 21 08:24:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq1JV-000607-Vq
	for gcvg-git@gmane.org; Mon, 21 May 2007 08:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbXEUGYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 02:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754370AbXEUGYJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 02:24:09 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:38927 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754082AbXEUGYI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2007 02:24:08 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 42B813F30C; Mon, 21 May 2007 08:24:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070521061954.GB8605@xp.machine.xx>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47969>

Hello,

> This gives me very nicely enumerated commits like tag-1-g<sha1-abbrev> for
> the commit o1 and tag-2-g<sha1-abbrev> for o2 ... you get the idea.

I get the idea but I don't like it very much. From my point of view the
commit id makes much more sense. The output is cut&pasted anyway.

        Thomas
