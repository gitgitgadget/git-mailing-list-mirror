From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Include local config before platform tweaks
Date: Wed, 6 Sep 2006 15:13:16 -0400
Message-ID: <5EDA627C-CBE3-4408-A4F5-D668BB2478BC@silverinsanity.com>
References: <9434EEBD-57BE-46D7-A2FF-069BB960AA44@silverinsanity.com> <7vlkoyarnx.fsf@assigned-by-dhcp.cox.net> <20060906033151.GB30540@spearce.org> <7vwt8h8nuf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 06 21:14:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL2q1-0000x6-1o
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 21:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWIFTN0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 15:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWIFTN0
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 15:13:26 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:10454 "EHLO
	silverinsanity.com") by vger.kernel.org with ESMTP id S1751473AbWIFTNZ
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 15:13:25 -0400
Received: from [192.168.1.100] (cpe-66-66-66-120.rochester.res.rr.com [66.66.66.120])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 308AD1FFC00A;
	Wed,  6 Sep 2006 19:13:18 +0000 (UTC)
In-Reply-To: <7vwt8h8nuf.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26553>

On Sep 6, 2006, at 3:18 AM, Junio C Hamano wrote:

> Thanks Shawn.  Brian does Shawn's patch work for you?

Short answer: Yes

Long answer:
The patch from his e-mail failed (git apply: fatal: corrupt patch at  
line 27), but manually making the changes worked.  I didn't pull  
before applying that, so that's probably the problem there.

~~Brian
