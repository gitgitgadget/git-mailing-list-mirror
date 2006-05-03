From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] Git wiki
Date: Wed, 03 May 2006 17:01:43 +0200
Message-ID: <4458C5D7.8010501@op5.se>
References: <20060502232553.GL27689@pasky.or.cz> <7virooj92i.fsf@assigned-by-dhcp.cox.net> <4d8e3fd30605030139k33c5a404k54861fdd02c87134@mail.gmail.com> <20060503090007.GM27689@pasky.or.cz> <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com> <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain> <20060503142957.GA9056@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 17:03:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbIrM-00011W-Iq
	for gcvg-git@gmane.org; Wed, 03 May 2006 17:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWECPBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 11:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbWECPBq
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 11:01:46 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:18412 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S965213AbWECPBp
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 May 2006 11:01:45 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id C44CD6BCF4; Wed,  3 May 2006 17:01:43 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060503142957.GA9056@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19488>

Shawn Pearce wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> 
>>On Wed, 3 May 2006, Paolo Ciarrocchi wrote:
>>
>>>On 5/3/06, Petr Baudis <pasky@suse.cz> wrote:
>>>
>>>>Dear diary, on Wed, May 03, 2006 at 10:39:07AM CEST, I got a letter
>>>>where Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> said that...
>>>>
>>>>>On 5/3/06, Junio C Hamano <junkio@cox.net> wrote:
>>>>>
>>>>>BTW, do you know why GIT has not been selected as SCM for OpenSolaris?
>>>>>(they choose Mercurial).
>>>>
>>>>I think it's explained somewhere in their forums (or mailing lists or
>>>>whatever they actually _are_).
>>>
>>>I only found the announcement, not the rationales.
>>
>>http://mail.opensolaris.org/pipermail/tools-discuss/2006-April/000366.html
>>
>>Looks like they didn't buy the argument about the uselessness of 
>>recording file renames.
> 
> 
> The final evaluations are available from here (at the very bottom
> of the page):
> 
>   http://opensolaris.org/os/community/tools/scm/
> 
> It looks like Mercurial doesn't support renames either, but a lot
> of users are asking for it to be supported.  So I don't think that's
> the reason.  It looks more like they didn't enjoy porting GIT 1.2.2
> (as 1.2.4 was found to not work in all cases) to Solaris and the
> tester ran into some problems with the conflict resolution support.
> 
> My own reading of the two final evaluations for GIT and Mercurial
> leaves me feeling like GIT is a more mature tool which is faster
> and more stable then Mercurial.  GIT seemed to be more reliable
> during testing then Mercurial was, despite the cloning issue.
> Which makes me surprised that OpenSolaris selected Mercurial instead.
> 

Considering Sun's CEO's common comments on Solaris' superiority over 
Linux I think it's safe to assume that the same CEO wouldn't exactly 
jump of joy if his employees started depending on a tool fathered by Linus.

No offence intended to Mercurial or its developers. Although I don't 
know anything about how it works I'm fairly sure Sun's developers would 
never agree to be forced to use an inferior tool (congrats Mercurial 
devs). However, I *do* think that in a tie-break Mercurial would win for 
political reasons.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
