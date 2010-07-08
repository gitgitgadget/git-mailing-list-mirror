From: Yann Dirson <ydirson@free.fr>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Thu, 8 Jul 2010 07:24:34 +0000 (UTC)
Message-ID: <loom.20100708T091339-404@post.gmane.org>
References: <201007032158.57700.jnareb@gmail.com> <loom.20100707T112304-178@post.gmane.org> <m3k4p7m0sv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 09:24:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWlTb-0004bY-Km
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 09:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563Ab0GHHYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 03:24:50 -0400
Received: from lo.gmane.org ([80.91.229.12]:51331 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581Ab0GHHYt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 03:24:49 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OWlTT-0004Vi-5K
	for git@vger.kernel.org; Thu, 08 Jul 2010 09:24:47 +0200
Received: from host.1.68.26.195.rev.coltfrance.com ([host.1.68.26.195.rev.coltfrance.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 09:24:47 +0200
Received: from ydirson by host.1.68.26.195.rev.coltfrance.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 09:24:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.68.26.1 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.4) Gecko/20100628 Iceweasel/3.6.4 (like Firefox/3.6.4))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150545>

Jakub Narebski <jnareb <at> gmail.com> writes:
> > > === 12. What kind of Git tools do you use? ===
> > > (multiple choice, with other)
> > [...]
> > >  + graphical blame or pickaxe tool
> > 
> > Mention gitk as example here ?
> 
> You meant here "git gui blame", didn't you?

Well, yes - that comes from the fact I only use the it from gitk :)

> > > === 16. Which of the following features do you use? ===
> > > (multiple choice, with other)
> > [...]
> > >  + one-way interaction with other SCMs (from SCM to git)
> > 
> > One-way from git to other SCM ?  I'm sure we care if many people do that :)
> 
> One way from SCM to git.

No, I was really suggesting to ask whether people work on a remote git repo
using another VCS, much like we do access other VCS' repo using git.  Not sure
whether this survey would reach those users, though.

 
> > + sophisticated diffcore stages (eg. directory rename, indent detection,
> >   content move)
> 
> Thanks.
> 
> BTW. I think wholesame directory rename detection is one of proposed
> features already.

d'oh - how could I miss it :)


> > > What features should be mentioned besides those above?  What criteria
> > > should we have for including features in this list?
> > 
> > Not sure if any reasonable idea that appeared on the list should be
> > left out.  Answers would provide feedback for features not necessarily
> > interesting to the average git <at> vger reader, but still appealing to our
> > users.
> 
> I don't think ideas about _internal_ changes need to be here.  Also,
> I do not remember _every_ feature proposel that appeared on the list...

At some point[1] we had a volunteer secretary willing to take note of bugs.  I
just went to see whether proposed features were tracked as well, but it appears
that initiative has stalled already :(

http://marc.info/?l=git&m=126299754631066&w=4

Best regards,
-- 
Yann
