X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicholas Allen <nick.allen@onlinehome.de>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 23:00:55 +0100
Message-ID: <456CB197.2030201@onlinehome.de>
References: <45357CC3.4040507@utoronto.ca> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com> <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com> <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr> <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net> <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com> <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de> <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 22:02:04 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
In-Reply-To: <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
X-Enigmail-Version: 0.94.0.0
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8f68dfdb39f9894a8a7411e7c5df1048
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32590>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpB0y-0001iT-KU for gcvg-git@gmane.org; Tue, 28 Nov
 2006 23:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757418AbWK1WBA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 17:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757412AbWK1WBA
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 17:01:00 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:13822 "EHLO
 moutng.kundenserver.de") by vger.kernel.org with ESMTP id S1757418AbWK1WA7
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 17:00:59 -0500
Received: from [84.190.155.117] (helo=[192.168.1.100]) by
 mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis), id
 0ML29c-1GpB0a2B59-0008Tn; Tue, 28 Nov 2006 23:00:57 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 28 Nov 2006, Nicholas Allen wrote:
>> and here's how it looked in git:
>> git status
> 
> Ehh. It told you exactly what happened when you actually did the merge, 
> didn't it?
> 
> Yeah, "git status" won't tell you _why_ it results in unmerged paths, but 
> the merge will have told you.  You must have seen that, but decided to 
> just ignore it and not post it, because it didn't support the conclusion 
> you wanted to get, did it?

I didn't do this deliberately - it's just because merge spewed out a
whole load of stuff at me that I didn't understand and therefore
overlooked the conflict message in it. I wasn't expecting to see it here
anyway and was hoping for a short and informative summary that I would
understand when I did a status.

Also what happens if I loose the messages because they scrolled off
screen or the power goes down, I need to reboot for some reason, or I
don't have time and want to shutdown my computer restart another day and
resolve the conflicts then? All useful conflict status is lost isn't it?
That's why I expected git status to tell me this in some understandable
manner and was not even expecting it to only be in the merge output....

