From: "David S. Miller" <davem@davemloft.net>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 13:31:20 -0800 (PST)
Message-ID: <20060323.133120.69312511.davem@davemloft.net>
References: <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
	<BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE>
	<Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: seanlkml@sympatico.ca, keithp@keithp.com, hpa@zytor.com,
	jbglaw@lug-owl.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 22:32:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMXPc-0005cL-9i
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 22:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWCWVba (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 16:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWCWVba
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 16:31:30 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32697
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932065AbWCWVba (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 16:31:30 -0500
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.60)
	(envelope-from <davem@davemloft.net>)
	id 1FMXOq-0003et-Eo; Thu, 23 Mar 2006 13:31:20 -0800
To: torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17874>

From: Linus Torvalds <torvalds@osdl.org>
Date: Thu, 23 Mar 2006 12:38:33 -0800 (PST)

> Yeah, I'm not counting things like Eclipse etc. I'm talking about "plain 
> SCM" environments, ie just basic SVN or CVS. What are we missing in that 
> department? (The only thing I can think of is a diff colorizer, which some 
> prople seem to really want).

gitk does color the diffs already, or are we talking about some
"side-by-side" multiple window thing showing "before" on the
left and "after" on the right?

Given that the gitk author has also written diff colorizers in the
past, I don't see providing this as being much of a problem :)
