From: "Mark Levedahl" <mdl123@verizon.net>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Thu, 1 Feb 2007 09:03:23 -0500
Message-ID: <epsrvd$i4p$1@sea.gmane.org>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl> <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C14563.8060707@verizon.net> <7vk5z2r27s.fsf@assigned-by-dhcp.cox.net> <m264am5u1r.fsf@gmail.com> <81b0412b0702010003t7becddf3x8fe6b36b0d84599b@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 15:04:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCcXd-00085U-9E
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 15:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbXBAODx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 09:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422898AbXBAODx
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 09:03:53 -0500
Received: from main.gmane.org ([80.91.229.2]:42705 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422893AbXBAODw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 09:03:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCcXP-0004kE-La
	for git@vger.kernel.org; Thu, 01 Feb 2007 15:03:43 +0100
Received: from sahara.mdnt.com ([12.109.151.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 15:03:43 +0100
Received: from mdl123 by sahara.mdnt.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 15:03:43 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: sahara.mdnt.com
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.3028
X-RFC2646: Format=Flowed; Response
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38355>

"Alex Riesen" <raa.lkml@gmail.com> wrote in message news:81b0412b0702010003t7becddf3x8fe6b36b0d84599b@mail.gmail.com...
> On 2/1/07, Seth Falcon <sethfalcon@gmail.com> wrote:
>>
>> > I am not in X right now and won't be able to look at it myself
>> > tonight.  Could folks on MacOS comment on Mark's patch?
>>
>> I gave it a quick spin on OS X.  gitk loads with a different geometry
>> than it had before, but seems to work the same.  If this fixes things
>> elsewhere, it seems fine here.
>>
>
> FWIW, I confirm that. Much better. Mouse selection still does not
> work in patch pane, but broken layout was the most annoying.
> Thanks, Mark!

You are welcome.
We can deal with other annoyances later assuming the layout change gets accepted. (the patch is already big) 
