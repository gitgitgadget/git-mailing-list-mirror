From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Fri, 3 Aug 2007 08:58:47 -0400
Message-ID: <20070803125846.GC28323@fieldses.org>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org> <20070803030459.GJ20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:59:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGwkG-000091-Bi
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 14:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762687AbXHCM6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 08:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762689AbXHCM6t
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 08:58:49 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36259 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762536AbXHCM6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 08:58:48 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IGwjv-0007h0-70; Fri, 03 Aug 2007 08:58:47 -0400
Content-Disposition: inline
In-Reply-To: <20070803030459.GJ20052@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54719>

On Thu, Aug 02, 2007 at 11:04:59PM -0400, Shawn O. Pearce wrote:
> Online help?  In git-gui?  :-)
> 
> We don't have an online help system yet.  Basically no documentation
> has been written for git-gui.  No thought has been put into how one
> should be organized, maintained, or displayed to the poor human
> who is just trying to learn more about Git and this gui thing it
> came with.
> 
> Yes, Help->Online Documentation is abvailable to most users, but
> that just opens your web browser (if it can find one) and points
> it to kernel.org's git manual.  Not exactly the best material for
> learning more about git-gui itself.

Fair enough.

Though I'd like to keep the main body of the manual focused on the major
command line tools, I'd have no objection to a separate chapter (or
appendix?) devoted to git-gui; then you could point directly at that.
Would that make sense?

--b.
