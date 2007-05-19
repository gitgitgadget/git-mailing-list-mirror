From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Documentation (mainly user-manual) patches
Date: Sat, 19 May 2007 01:19:20 -0400
Message-ID: <20070519051920.GB2679@fieldses.org>
References: <20070518033746.GB30144@fieldses.org> <20070518045634.GU4489@pasky.or.cz> <20070518134316.GA21925@fieldses.org> <20070519040212.GC3141@spearce.org> <20070519041357.GA2679@fieldses.org> <20070519043234.GE3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 19 07:19:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpHLv-0006Bv-Ph
	for gcvg-git@gmane.org; Sat, 19 May 2007 07:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982AbXESFT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 01:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755574AbXESFT1
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 01:19:27 -0400
Received: from mail.fieldses.org ([66.93.2.214]:33394 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746AbXESFT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 01:19:26 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HpHLc-0004TM-Tg; Sat, 19 May 2007 01:19:20 -0400
Content-Disposition: inline
In-Reply-To: <20070519043234.GE3141@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47714>

On Sat, May 19, 2007 at 12:32:34AM -0400, Shawn O. Pearce wrote:
> It connects to the remote URL, lists the refs found there, and
> finds any that has the commit you passed in as the 3rd argument
> (defaults to HEAD).  If none match it prints ..BRANCH.NOT.VERIFIED..
> as the branch name, to signal no branch points at the given commit,
> which means it cannot be (easily) pulled.
> 
> Not getting that means you have too old of a Git to have my branch
> improvements.  It was in ff06c743dc, which is in master and hence
> should be in 1.5.2 final.

OK, that's very nifty.

> > (And I'm not sure
> > about that "change since commit..." stuff--that seems like slight
> > overkill.)
> 
> Yea, it can be a little overkill sometimes.  But the maintainer
> knows where you started from.  If that commit is horribly old he
> might wonder what is going on.  ;-)

Is that really helpful in practice?  Well, what would I know.

--b.
