From: Dieter Ries <clip3@gmx.de>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Sun, 23 Dec 2007 14:05:00 +0100
Message-ID: <476E5CFC.5070301@gmx.de>
References: <200612241807.kBOI746w008739@laptop13.inf.utfsm.cl> <476E42BF.1010300@garzik.org> <alpine.LFD.0.9999.0712230701520.14863@localhost.localdomain> <476E50DC.1040701@garzik.org> <alpine.LFD.0.9999.0712230715490.15596@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff Garzik <jeff@garzik.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754215AbXLWNFZ@vger.kernel.org Sun Dec 23 14:05:52 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754215AbXLWNFZ@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6QWc-0006zw-LQ
	for glk-linux-kernel-3@gmane.org; Sun, 23 Dec 2007 14:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbXLWNFZ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 23 Dec 2007 08:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbXLWNFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Dec 2007 08:05:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:55324 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752067AbXLWNFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Dec 2007 08:05:04 -0500
Received: (qmail invoked by alias); 23 Dec 2007 13:05:02 -0000
Received: from p54A8CE5B.dip.t-dialin.net (EHLO [192.168.1.11]) [84.168.206.91]
  by mail.gmx.net (mp058) with SMTP; 23 Dec 2007 14:05:02 +0100
X-Authenticated: #40245974
X-Provags-ID: V01U2FsdGVkX19cNHNMdW9cnFiSsQ8pSoSn8SX4lrl+qgLc9K7uA2
	4mXmm+12cg49ew
User-Agent: Thunderbird 2.0.0.9 (X11/20071126)
In-Reply-To: <alpine.LFD.0.9999.0712230715490.15596@localhost.localdomain>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69180>

Robert P. J. Day schrieb:
> On Sun, 23 Dec 2007, Jeff Garzik wrote:
> 
>> Robert P. J. Day wrote:
>>> On Sun, 23 Dec 2007, Jeff Garzik wrote:
>>>
>>>> Another year, another update!  :)
>>>>
>>>> The kernel hacker's guide to git has received some updates:
>>>>
>>>> 	http://linux.yyz.us/git-howto.html
>>>>
>>>> This includes all the input sent to me in the past several months,
>>>> as well as a few new tips and tricks I use on a regular basis.
>>>>
>>>> In general, this document is designed to be a quick-start cookbook,
>>>> and not a comprehensive introduction.
>>> there's one issue i have with this document, and that's that i wish it
>>> more carefully distinguished between regular git "user" tasks, and git
>>> "developer" tasks.
>>>
>>> i may be mistaken, but it would seem that a lot of folks are going to
>>> be what i call basic users, who only want to update their git tree,
>>> check the logs, check the status and so on.  and if they start to get
>>> ambitious, they might make some changes to the tree, do a diff, and
>>> submit a patch.  but in the beginning, they won't be making commits or
>>> switching branches, etc.
>>>
>>> in short, i can see the value of something like a "getting started
>>> with git as a basic user" tutorial.  does such a thing exist?
>> hmmm.  There's the tutorial linked at the bottom of the page, which
>> in turn links to
>> http://www.kernel.org/pub/software/scm/git/docs/everyday.html
>>
>> git is a developer's tool, so I sorta targetted that audience.  I
>> definitely agree that is not only git audience...
> 
> just to be clear, i'm not complaining about the quality of the
> document above, but when i got started with git, what i really wanted
> was a list of what i (as a simple, non-developer user) could do once i
> cloned a repository.
> 
> to that end, i put together my own little reference list of git
> commands.  for example, i collected ways to examine my repository --
> git commands like branch, tag, log/shortlog, what-changed, show, grep,
> blame, that sort of thing.  exactly the kind of stuff a new user might
> want to know about, even without the ability to change anything.

Could you perhaps publish your reference list as kind of a christmas
gift to all basic users like me?


cu
Dieter

ps.: sorry for sending this twice, messed up recipients.
> 
> just my $0.02.
> 
> rday
> --
> 
> ========================================================================
> Robert P. J. Day
> Linux Consulting, Training and Annoying Kernel Pedantry
> Waterloo, Ontario, CANADA
> 
> http://crashcourse.ca
> ========================================================================
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

