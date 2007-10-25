From: Federico Mena Quintero <federico@novell.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007
	unfinishedsummary continued
Date: Thu, 25 Oct 2007 13:02:19 -0500
Message-ID: <1193335339.4522.398.camel@cacharro.xalalinux.org>
References: <20071024212854.GB6069@xp.machine.xx>
	 <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>
	 <Pine.LNX.4.64.0710242258201.25221@racer.site>
	 <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de>
	 <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se>
	 <Pine.LNX.4.64.0710251112390.25221@racer.site> <472070E5.4090303@op5.se>
	 <20071025132401.GA22103@thunk.org> <4720AF05.3050308@op5.se>
	 <20071025152159.GB22103@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:00:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il70L-0006Hl-T2
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbXJYSAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbXJYSAM
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:00:12 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:27614 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbXJYSAK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 14:00:10 -0400
Received: from [164.99.192.129] ([164.99.192.129])
	by jericho.provo.novell.com with ESMTP; Thu, 25 Oct 2007 12:00:01 -0600
In-Reply-To: <20071025152159.GB22103@thunk.org>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62339>

On Thu, 2007-10-25 at 11:21 -0400, Theodore Tso wrote:

> And of course it's inelegant.  You just told us we were dealing with
> CVS-brain-damaged corporate developers who can't be bothered to learn
> about the fine points of using things the git way.

Ignore the corporate developers who use SCMs only because their company
requires them to.  Git is not the right thing for them; some
Eclipse-based monstrosity probably is.  It's like the horrendous
Oracle-based expense-reporting thing we have to use at Novell; I use it
because they make me, not because I'm particularly excited about
reporting expenses :)

However, *do think* of the free software developers who have been using
CVS forever.  You won't make friends among them if you keep saying, "you
use CVS?  You are brain-damaged, then."  CVS has been as good/bad to
them as to anyone else, and they are probably delighted to get a better
solution.  That solution needs to take into account the concepts to
which they have been exposed for the past N years.  Just because your
new concepts are better, doesn't mean that their old ones were wrong in
their time.

You don't find quantum physicists saying, "... yeah, like Newton's
brain-damaged followers" :)

  Federico
