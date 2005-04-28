From: "Barry Silverman" <barry@disus.com>
Subject: RE: A shortcoming of the git repo format
Date: Thu, 28 Apr 2005 11:08:26 -0400
Message-ID: <IGEMLBGAECDFPIKMIMLCEEGECHAA.barry@disus.com>
References: <Pine.LNX.4.58.0504271722260.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <hpa@zytor.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:01:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRAV6-0000WU-1a
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 17:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVD1PFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 11:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVD1PFn
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 11:05:43 -0400
Received: from borg.disus.com ([199.243.199.210]:62989 "EHLO borg.disus.com")
	by vger.kernel.org with ESMTP id S262111AbVD1PF0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 11:05:26 -0400
Received: from ARNOLD (dhcpap.secdisus.com [199.246.34.150])
	by borg.disus.com (8.11.6/8.11.6) with SMTP id j3SF48Y01609;
	Thu, 28 Apr 2005 11:04:08 -0400
To: "Linus Torvalds" <torvalds@osdl.org>, "Tom Lord" <lord@emf.net>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.58.0504271722260.18901@ppc970.osdl.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>In contrast, with git, I'm totally uninterested in anything that doesn't
>>make my kernel work go faster or more smoothly, and does so _today_. Which
>>makes me a cantancerous old bastard, and bit the heads off anybody who
>>isn't focused on that one thing.

Focus is the totally operative word here!

If you really want to feel good about the world, re-read the initial set of
git postings that Linus made on April 7th:
http://kerneltrap.org/node/4982

Contrast the picture today with the fact that three weeks ago:
April 7:
1) the kernel workflow was at a standstill
2) git was just a totally unproven concept in Linus' head, that could have
ended up as a band-aid while a REAL SCM (...sound of choking from the
wings...) was chosen
3) the performance issues in dealing with both the size of the kernel
project, and the velocity of the changes were completely up in the air

Today:
1) the kernel workflow has restarted, and has already made its first
milestone
2) git is solid in architecture, is maintained and updated by a proven set
of developers, and has been demonstrated to have all the performance
necessary going forward
3) the primary traffic on the mailing list is related to tactical issues -
not architecture, or strategy, or big-ticket item stuff - with the
occasional flame about "renames" ;-)

Are there any large strategic issues left to be resolved for git?, or is it
just a matter of getting all the kernel developers over the learning curve,
and iterating the details of the workflow to make everyone maximally
productive?

How long do you think it will take for the kernel workflow to get back to
its height during the BK days?

The achievement of going from a complete standstill, to full velocity kernel
workflow production in a couple of months has got to be something everyone
involved should be intensely proud of.
Thanks, Linus, for being such a "cantancerous old bastard". I don't think it
could have happened if you were anything but....

Barry Silverman

