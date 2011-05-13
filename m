From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git-p4 issue
Date: Fri, 13 May 2011 14:31:32 +0000 (UTC)
Message-ID: <loom.20110513T162233-874@post.gmane.org>
References: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com> <BANLkTimmVQAcx7hiQFUBcoAGdvPhktPuMg@mail.gmail.com> <BANLkTikDDDtyJB992DFNtvgMrGvbWf=rMw@mail.gmail.com> <BANLkTinJecAsXt+5JzscFYEx_ez2q9DioQ@mail.gmail.com> <20110420003100.GC28768@arf.padd.com> <BANLkTikYDR+bzJQGip9BFo-BSgsBqEcQjQ@mail.gmail.com> <BANLkTik49sCiBnf6ZofrtW+45uR6ZC+C9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 16:31:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKtPH-0008MG-BD
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 16:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759313Ab1EMObu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 10:31:50 -0400
Received: from lo.gmane.org ([80.91.229.12]:37576 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758712Ab1EMObu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 10:31:50 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QKtP7-0008F9-Ix
	for git@vger.kernel.org; Fri, 13 May 2011 16:31:47 +0200
Received: from 57.79.130.188 ([57.79.130.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 May 2011 16:31:45 +0200
Received: from vitor.hda by 57.79.130.188 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 May 2011 16:31:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 57.79.130.188 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:2.0.1) Gecko/20100101 Firefox/4.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173541>

Hi Michael,

Michael Horowitz <michael.horowitz <at> ieee.org> writes:

> 
> Vitor,
> 
> > Could you please search for the following set of patches in this
> > mailing list?
> >
> > [PATCH v2 0/3] git-p4: Improve branch support
> >
> > I think I sent v2 twice somehow, so please make sure you pick the
> > latest ;)
> > In these patches I add the possibility to use a "git-p4.branchList"
> > configuration to define the branches. The patch is still to be
> > approved because most people in the mailing list do not use branch
> > detection, but I use it daily and it is working in my side. Could
> > you please test it?
> 
> Can you send this patch again?  It looks like you had previously
> responded to the list only, so I never got this message, as I wasn't
> on the list at the time (I am now).  I only saw this because I was
> searching the archive for something else.  I searched for the patch,
> but the actual patch body doesn't seem to be in the archive.

I am also not in the mailing list, I just follow its RSS and try to
follow up on the git-p4 related topics ;) That is the reason why you
were not included in the reply.

But I have been a bit busy and did not see this email passing by. Sorry.
Luckily I had a tab opened in this thread, which I looked at today
wondering what it was about! :P

Please follow the link to the thread [1] and you can open each of the
entries. Take care not to apply patch 1/3 as it may require you to clone
everything again.

> Thanks,
> 
> Mike
> 

Regards,
Vitor

[1] http://thread.gmane.org/gmane.comp.version-control.git/167998/focus=168000
