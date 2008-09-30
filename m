From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Tue, 30 Sep 2008 08:13:51 +0200
Message-ID: <48E1C39F.4070906@op5.se>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl> <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl> <7vzlmkpltb.fsf@gitster.siamese.dyndns.org> <20080921104238.GA9217@sigill.intra.peff.net> <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl> <20080929224430.GA11545@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 30 08:16:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkYWd-0004Va-2U
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 08:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbYI3GO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 02:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbYI3GO0
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 02:14:26 -0400
Received: from mail.op5.se ([193.201.96.20]:54022 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbYI3GO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 02:14:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1507D1B80077;
	Tue, 30 Sep 2008 08:05:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KDo8mAezRxAd; Tue, 30 Sep 2008 08:05:09 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id CE72F1B80051;
	Tue, 30 Sep 2008 08:05:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080929224430.GA11545@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97065>

Jeff King wrote:
> On Mon, Sep 29, 2008 at 10:09:17PM +0200, Pieter de Bie wrote:
> 
>> How about something like
>>
>> 	Created commit abcd1234 on widget -- "subwidget: one line summary"
> 
> I think that is probably just trading one visual problem for another.
> That is, there are other people will have the same problem with "--"
> that I had with ": ".
> 

Created 6207abc (subwidget: one quite long line of sum...) on <branch>

"commit" is just noise. Parentheses are often used to extemporize when
using normal written language so it should work well here too.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
