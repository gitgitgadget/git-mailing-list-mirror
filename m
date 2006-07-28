From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Re: Licensing and the library version of git
Date: Fri, 28 Jul 2006 00:24:56 +0000 (UTC)
Message-ID: <eablgn$c6a$1@sea.gmane.org>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com>
	<20060727114105.GZ13776@pasky.or.cz>
	<Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com>
	<20060727131127.GA13776@pasky.or.cz>
	<9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-From: git-owner@vger.kernel.org Fri Jul 28 02:25:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6GAH-0007GJ-Es
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 02:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWG1AZN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 20:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWG1AZN
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 20:25:13 -0400
Received: from main.gmane.org ([80.91.229.2]:26821 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750870AbWG1AZL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 20:25:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G6GA6-0007FV-Rm
	for git@vger.kernel.org; Fri, 28 Jul 2006 02:25:06 +0200
Received: from 88-109-231-203.dynamic.dsl.as9105.com ([88.109.231.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Jul 2006 02:25:06 +0200
Received: from wildfire by 88-109-231-203.dynamic.dsl.as9105.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Jul 2006 02:25:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 88-109-231-203.dynamic.dsl.as9105.com
User-Agent: pan 0.102 ("From the Years of Neon Through Iodine")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24356>

On Thu, 27 Jul 2006 12:11:00 -0400, Jon Smirl wrote:

> On 7/27/06, Petr Baudis <pasky@suse.cz> wrote:
>> > You may like trying to force GPL onto the app but many apps are
>> > stuck with the license they have and can't be changed since there is
>> > no way to contact the original developers.
>>
>> At this point, git-shortlog lists exactly 200 people (at least entries
>> like Unknown or No name are all linux@horizon.com ;-).
> 
> Inability to integrate with Microsoft Visual Studio is going to have a
> lot of impact on the cross platform use of git.  

Could you stop with the histrionics please?

> Is a conscious
> decision being made to stop this integration or is this just unplanned
> side effect of the original license? If this is an unplanned side
> effect, the quicker we move, the easier it is to fix.

So, using CVSNT (a GPL'd SCCI provider) and git-cvsserver would be a way
to continue.  I'm assuming that the primary functionality they want via
their IDE is checkout/diff/commit/log.

Quite a lot of Windows developers have no problems using multiple tools
for things, I'd assume they would also be able to use any existent port
of git (to Windows) to do the esoteric things like branching/bisect/etc.

Anand
