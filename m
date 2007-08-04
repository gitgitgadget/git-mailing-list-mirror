From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Sat, 4 Aug 2007 10:35:59 -0400
Message-ID: <20070804143559.GC10294@fieldses.org>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org> <20070803030459.GJ20052@spearce.org> <20070803125846.GC28323@fieldses.org> <20070804062010.GQ20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 16:36:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHKjg-0005AM-Df
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 16:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758826AbXHDOgF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 10:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757310AbXHDOgE
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 10:36:04 -0400
Received: from mail.fieldses.org ([66.93.2.214]:39096 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757082AbXHDOgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 10:36:01 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IHKjX-0005xo-FK; Sat, 04 Aug 2007 10:35:59 -0400
Content-Disposition: inline
In-Reply-To: <20070804062010.GQ20052@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54859>

On Sat, Aug 04, 2007 at 02:20:10AM -0400, Shawn O. Pearce wrote:
> But at this point in git (and git-gui's) life I think it would
> be very worthwhile to devote an entire (new) chapter to git-gui,
> maybe as part of git 1.5.4/git-gui 0.9.0.  I think we're far too
> late in the 1.5.3 cycle to do it now.  I personally won't have the
> time to even try to rough draft something anytime soon, let alone
> let others copy-edit me before Juino releases 1.5.3.  :)
> 
> Being bundled with core git has brought git-gui a sizeable and
> growing userbase, and more and more users are discovering it
> each day.  We're now seeing it be translated into many different
> languages, and it is a somewhat core part of the MSYS port as many
> Windows users prefer to click in GUIs over type in cmd.exe terminal
> windows (can't say I blame them, cmd.exe is aweful!).
> 
> In other words I think git-gui should get roughly as much attention
> from the user manual as git-add/rm/mv/commit/checkout/branch get,
> as it offers the same feature set.  But it shouldn't distract from
> the command line part of the manual.
> 
> Maybe we should write parts of the manual in a "choose your own
> adventure style" and use different chapters for different paths.
> I think users can easily decide between the command line "i like to
> type" vs. the gui "i like to click" paths and focus their attention
> to the material they are most interested in.  :-)

Sure.

For now, though, I think it'd be simplest to start with an entirely
separate appendix.  And find a way to make links to that chapter are
prominently featured in Windows ports, as that sounds like an immediate
need.

And then later as git-gui progresses we can figure out how to integrate
it better.

--b.
