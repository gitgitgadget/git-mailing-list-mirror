From: Mike Hommey <mh@glandium.org>
Subject: Re: best git practices, was Re: Git User's Survey 2007
	unfinishedsummary continued
Date: Thu, 25 Oct 2007 20:04:51 +0200
Organization: glandium.org
Message-ID: <20071025180451.GA6349@glandium.org>
References: <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se> <Pine.LNX.4.64.0710251112390.25221@racer.site> <472070E5.4090303@op5.se> <20071025132401.GA22103@thunk.org> <4720AF05.3050308@op5.se> <20071025152159.GB22103@thunk.org> <1193335339.4522.398.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Federico Mena Quintero <federico@novell.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il76M-00087g-1T
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbXJYSGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbXJYSGX
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:06:23 -0400
Received: from vawad.err.no ([85.19.200.177]:55003 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbXJYSGW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 14:06:22 -0400
Received: from aputeaux-153-1-48-133.w82-124.abo.wanadoo.fr ([82.124.136.133] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1Il75i-0007br-DB; Thu, 25 Oct 2007 20:06:00 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1Il74d-0001ee-I1; Thu, 25 Oct 2007 20:04:51 +0200
Content-Disposition: inline
In-Reply-To: <1193335339.4522.398.camel@cacharro.xalalinux.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62343>

On Thu, Oct 25, 2007 at 01:02:19PM -0500, Federico Mena Quintero wrote:
> On Thu, 2007-10-25 at 11:21 -0400, Theodore Tso wrote:
> 
> > And of course it's inelegant.  You just told us we were dealing with
> > CVS-brain-damaged corporate developers who can't be bothered to learn
> > about the fine points of using things the git way.
> 
> Ignore the corporate developers who use SCMs only because their company
> requires them to.  Git is not the right thing for them; some
> Eclipse-based monstrosity probably is.  It's like the horrendous
> Oracle-based expense-reporting thing we have to use at Novell; I use it
> because they make me, not because I'm particularly excited about
> reporting expenses :)
> 
> However, *do think* of the free software developers who have been using
> CVS forever.  You won't make friends among them if you keep saying, "you
> use CVS?  You are brain-damaged, then."  CVS has been as good/bad to
> them as to anyone else, and they are probably delighted to get a better
> solution.  That solution needs to take into account the concepts to
> which they have been exposed for the past N years.  Just because your
> new concepts are better, doesn't mean that their old ones were wrong in
> their time.

It's probably just a matter of writing a "git for CVS users" document.

Mike
