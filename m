From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: send-email sending shallow threads by default
Date: Sun, 15 Feb 2009 21:55:17 -0500
Message-ID: <D365EECA-C410-4DDF-83B5-7FA14C593FC1@silverinsanity.com>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <20090216000732.GC3503@coredump.intra.peff.net> <5ABF2654-851C-47F3-9D3A-3F73F13AC5DC@ai.rug.nl> <20090216024308.GB18780@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Pieter de Bie <pdebie@ai.rug.nl>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 03:58:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYtgG-0001jV-A7
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 03:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbZBPCz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 21:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbZBPCz1
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 21:55:27 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:50648 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbZBPCz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 21:55:26 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 1A3D91FFC282; Mon, 16 Feb 2009 02:55:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=4.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb3
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 215161FFC273;
	Mon, 16 Feb 2009 02:55:08 +0000 (UTC)
In-Reply-To: <20090216024308.GB18780@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110118>


On Feb 15, 2009, at 9:43 PM, Jeff King wrote:

> On Mon, Feb 16, 2009 at 12:09:11AM +0000, Pieter de Bie wrote:
>
>> On 16 feb 2009, at 00:07, Jeff King wrote:
>>
>>> Are there common readers that thread but do not order by date?
>>
>> Apple's Mail orders by date received, rather than date sent
>
> Hmph. I guess it is a potential problem, then. If you use Apple Mail,
> can you report on whether out of order threads have been a problem
> (since earlier discussion revealed that both deep and shallow threads
> are found in the wild)?

I have noticed patches listed out of order, but I simply just open  
them according to the [PATCH N/M] in the subject.  I wouldn't really  
call it a problem.

~~ Brian
