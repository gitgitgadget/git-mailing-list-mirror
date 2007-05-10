From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Merging commits together into a super-commit
Date: Thu, 10 May 2007 15:51:52 -0400
Message-ID: <20070510195152.GS13719@fieldses.org>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192212.GP13719@fieldses.org> <20070510194742.GC4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 10 21:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmEgG-00019H-T6
	for gcvg-git@gmane.org; Thu, 10 May 2007 21:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbXEJTv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 15:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbXEJTv7
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 15:51:59 -0400
Received: from mail.fieldses.org ([66.93.2.214]:41747 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbXEJTv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 15:51:58 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HmEg4-0000tX-LF; Thu, 10 May 2007 15:51:52 -0400
Content-Disposition: inline
In-Reply-To: <20070510194742.GC4489@pasky.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46892>

On Thu, May 10, 2007 at 09:47:42PM +0200, Petr Baudis wrote:
> Actually, you don't have to - if you don't specify the patch names,
> stgit will make them up itself using the subject of the commit message
> as a base.

You still have to on new patches, right?

> And by the way, I absolutely love that - when viewing the stack, it's
> very useful to see what commits you still have to go etc. - stg series
> is concise yet fully descriptive.

Sure.

I mainly find myself using gitk origin.. for that now.  My main problem
there is just that it's slow.  (And File->Update) seems possibly even
slower than just killing and restarting it.--b.
