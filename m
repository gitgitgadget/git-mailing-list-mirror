From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 17:45:48 -0400
Organization: None, usuallly detectable by casual observers
Message-ID: <200508111745.49128.gene.heskett@verizon.net>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org>
 <7vfytgl25g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Sebastian Kuzminsky <seb@highlab.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 23:46:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3Krb-00061F-GG
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 23:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVHKVpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 17:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVHKVpV
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 17:45:21 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:26351 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932199AbVHKVpU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 17:45:20 -0400
Received: from coyote.coyote.den ([141.153.76.212])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IL200HBDV3GUB42@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 11 Aug 2005 16:45:17 -0500 (CDT)
In-reply-to: <7vfytgl25g.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Content-disposition: inline
User-Agent: KMail/1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 11 August 2005 15:11, Junio C Hamano wrote:
>Linus Torvalds <torvalds@osdl.org> writes:
>> On Wed, 10 Aug 2005, Sebastian Kuzminsky wrote:
>>> People still use GNU Interactive Tools.  Not just crazy, stupid
>>> people, and I bet not just Debian people.
>>
>> Why do you say that?
>>
>> Do you have anybody who actually does, or are you just claiming
>> so?
>
>Debian folks have a handy way to substantiate that claim or get
>that claim proven wrong, and I am somewhat surprised that nobody
>mentioned it so far.
>
>Debian popularity contest (http://popcon.debian.org/).
>
>Here is an excerpt I just made.
>
>    <name> is the package name;
>    <inst> is the number of people who installed this package;
>    <vote> is the number of people who use this package regularly;
>    <old>  is the number of people who installed, but don't use
>          this package regularly;
>    <recent> is the number of people who upgraded this package
> recently;
>
>    rank  name            inst    vote     old recent
>    1     base-files      7147    6777     158    212
>    2     base-passwd     7147    6724     163    260
>    3     debianutils     7147    6739     120    288
>    4     sed             7147    6763     155    229
>    ...
>    6591  git              114      24      83      7
>    ...
>    25555 git-core           2       1       0      1 (Not in sid)
>    29939 cogito-scm         1       0       1      0 (Not in sid)
>    ...
>    46416 zope2.6            0       0       0      0
>    -------------------------------------------------
>    46416 Total        6768849 2118048 2306009 595621
>
>So yes, among 46.5K packages in the known universe, the other
>git ranks 6600th.  Does that mean it is popular?  I dunno.
>
>Obviously, not everybody who installs Debian participates in
>popcon.  The sample size of the above statistics is 7147
>installations of base-files.
>
>Among these 7147 sample installations, the other git was
>installed by 114 people, and 24 people regularly use it.

This obviously is not even a fair assesment of the potential
popularity of this new kernel package admin tool.  By holding to this
attitude, you will surely alienate linux users away from debian.

If so far, only 114 people out of the 7147 who were kind enough to
fill out a questionaire have installed the debian 'git' and 24 report
that they are using this tool, then obviously once a stable release of
the Linus version of git has been achieved, the user count of the new
tool will handily exceed the user count of the older and totally
different toolkit from gnu.  This will occur within 24 hours of a
working, stable release of the Linus git.  Possibly aleady has
occured, I have it (the rpm) here already.

Methinks its a good time for one or the other to come up with a new
name.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
