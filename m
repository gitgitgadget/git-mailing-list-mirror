From: Andreas Ericsson <ae@op5.se>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Wed, 03 Jan 2007 14:55:20 +0100
Message-ID: <459BB5C8.4000608@op5.se>
References: <86y7p57y05.fsf@blue.stonehenge.com>	 <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>	 <86r6uw9azn.fsf@blue.stonehenge.com>	 <Pine.LNX.4.64.0612181625140.18171@xanadu.home>	 <86hcvs984c.fsf@blue.stonehenge.com>	 <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>	 <8664c896xv.fsf@blue.stonehenge.com> <46a038f90612181502y3e2a41cds7f16113ad0270f31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 14:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H26ag-0001ed-JH
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 14:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbXACNzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 08:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbXACNzY
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 08:55:24 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:36803 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbXACNzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 08:55:22 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id A2FB36BCC7; Wed,  3 Jan 2007 14:55:20 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90612181502y3e2a41cds7f16113ad0270f31@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35868>

Martin Langhoff wrote:
> 
> Once you are packed it's sweet, but large repos are a pain to deal
> with. You won't impress anyone with performance over a linux kernel
> repo -- starting up gitk can take a long time.

I'd suggest running qgit instead, and make sure you've run it once on 
the repo you're demoing. qgit has a nice little cache where it tucks 
away most of the data it uses, which makes it draw things a lot faster.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
