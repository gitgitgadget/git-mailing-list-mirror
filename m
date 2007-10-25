From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007	unfinishedsummary
 continued
Date: Thu, 25 Oct 2007 22:08:14 +0200
Message-ID: <4720F7AE.7020603@op5.se>
References: <20071024212854.GB6069@xp.machine.xx>	 <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>	 <Pine.LNX.4.64.0710242258201.25221@racer.site>	 <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de>	 <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se>	 <Pine.LNX.4.64.0710251112390.25221@racer.site> <472070E5.4090303@op5.se>	 <20071025132401.GA22103@thunk.org> <4720AF05.3050308@op5.se>	 <20071025152159.GB22103@thunk.org> <1193335339.4522.398.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Federico Mena Quintero <federico@novell.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 22:09:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il90x-0006Ym-N1
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 22:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762454AbXJYUIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 16:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762381AbXJYUIY
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 16:08:24 -0400
Received: from mail.op5.se ([193.201.96.20]:51860 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761463AbXJYUIU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 16:08:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C7240173071F;
	Thu, 25 Oct 2007 22:08:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.498
X-Spam-Level: 
X-Spam-Status: No, score=-2.498 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BAb-KpMYHuI0; Thu, 25 Oct 2007 22:08:15 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 0A4FB1730717;
	Thu, 25 Oct 2007 22:08:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <1193335339.4522.398.camel@cacharro.xalalinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62364>

Federico Mena Quintero wrote:
> On Thu, 2007-10-25 at 11:21 -0400, Theodore Tso wrote:
> 
>> And of course it's inelegant.  You just told us we were dealing with
>> CVS-brain-damaged corporate developers who can't be bothered to learn
>> about the fine points of using things the git way.
> 
> Ignore the corporate developers who use SCMs only because their company
> requires them to.  Git is not the right thing for them;

Quite contrary to what I think, and quite contrary to what Linus said in
his google speach. The problem with using a chainsaw instead of a tooth-
pick is that it's much easier to hurt yourself with a chainsaw. It's a
lot easier to get real work done though.

> some
> Eclipse-based monstrosity probably is.  It's like the horrendous
> Oracle-based expense-reporting thing we have to use at Novell; I use it
> because they make me, not because I'm particularly excited about
> reporting expenses :)
> 

Nobody's particularly excited about reporting expenses. That's why there
are so few OSS solutions for it, and the ones that exist suck horribly
because whoever got the job of making the system knew his users would
simply hate it, no matter how perfect it was. It's one of those things ;-)

> However, *do think* of the free software developers who have been using
> CVS forever.  You won't make friends among them if you keep saying, "you
> use CVS?  You are brain-damaged, then."  CVS has been as good/bad to
> them as to anyone else, and they are probably delighted to get a better
> solution.  That solution needs to take into account the concepts to
> which they have been exposed for the past N years.  Just because your
> new concepts are better, doesn't mean that their old ones were wrong in
> their time.
> 

Well, perhaps they were. CVS was a fairly important learning phase, much
like Thomas Edison who first discovered 2000 ways of not making a light-
bulb. It doesn't make them less valuable though, and the reason to keep
going until perfection is reached is that machines are made for work, and
humans are made for fun.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
