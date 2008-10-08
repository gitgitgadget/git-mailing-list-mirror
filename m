From: David Soria Parra <sn_@gmx.net>
Subject: Re: Feature Request: Branch Annotations
Date: Thu, 09 Oct 2008 01:20:44 +0200
Message-ID: <48ED404C.2000405@gmx.net>
References: <d2115f4f0810080341m27c4ca9bv9b1e9b66704ef3fa@mail.gmail.com> <d2115f4f0810080348t62e18b14x1dfe798974332b05@mail.gmail.com> <d2115f4f0810080349o30b6bc2labc2745b8d981e0d@mail.gmail.com> <48ECB5CB.4010703@gmx.net> <7vwsgiptph.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rotem Yaari <vmalloc@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 01:22:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KniLw-0008OQ-8Y
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 01:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbYJHXUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 19:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbYJHXUs
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 19:20:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:59777 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754111AbYJHXUs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 19:20:48 -0400
Received: (qmail invoked by alias); 08 Oct 2008 23:20:46 -0000
Received: from p57AED7EB.dip.t-dialin.net (EHLO [192.168.2.25]) [87.174.215.235]
  by mail.gmx.net (mp049) with SMTP; 09 Oct 2008 01:20:46 +0200
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX18R2AwPBecR2HRRCrtn11hm0s8IMb59VisNKOzrfF
	rivGjLzDeo7mqp
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <7vwsgiptph.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97809>


> Haven't people watched Linus on google tech talk?  Here is an excerpt from
> the transcript (http://git.or.cz/gitwiki/LinusTalk200705Transcript):
> 
>     ... well actually you shouldn't call it "test", you should basically
>     name your branches the way you name your functions, you should call
>     them something short and sweet and to the point -- What is that branch
>     doing.
> 
> IOW, why did you name the branch "ds/fix" and not "ds/fix-bla"?

Okay I just choosed a bad example. Actually I call it ds/fix-function, 
but nevertheless more additional description can be useful when dealing 
with a lot of branches. But yes, there might be porcelains that can do that.
