From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Tue, 17 Apr 2007 07:08:08 +0200
Message-ID: <20070417050808.GC29569@xp.machine.xx>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org> <20070416181352.GB29569@xp.machine.xx> <Pine.LNX.4.64.0704161958470.6021@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 07:14:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdg1m-0005ZQ-8X
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 07:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030671AbXDQFOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 01:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbXDQFOu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 01:14:50 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54103 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1753975AbXDQFOu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2007 01:14:50 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Apr 2007 01:14:49 EDT
Received: (qmail 31211 invoked by uid 0); 17 Apr 2007 05:08:07 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 17 Apr 2007 05:08:07 -0000
Mail-Followup-To: git@vger.kernel.org,
	Julian Phillips <julian@quantumfyre.co.uk>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704161958470.6021@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44733>

On Mon, Apr 16, 2007 at 08:01:29PM +0100, Julian Phillips wrote:
>  On Mon, 16 Apr 2007, Peter Baumann wrote:
> 
> >
> > master
> > | next			commit comment for next
> > o  |		commit comment for master~1
> > |  o			commit comment for next~1
> > o  |	[ ... guess whats next :-)		you get the idea ...]
> > |  o
> > |  |
> > o /
> > |
> >
> > tig comes near it, but it only linerarises the branches, so you can't see
> > where there was a mergepoint/fork. I'd really like these visuallization of
> > the commit graph in some of the text viewers. I normally don't care about
> > the _full_ commit text, only if I visually understand what's happening I'm
> > looking at the individual commits and the patches.
> 
>  If you turn on the revision graph visualisation (press 'g' whil in main 
>  view) then tig will show merges and forks ... looks a little like your 
>  diagram above in fact.
> 
>  -- 
>  Julian
> 

Nice. I didn't now of this feature.

Peter
