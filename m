From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Fix signal handler
Date: Wed, 03 Feb 2010 17:24:43 +0100
Message-ID: <4B69A34B.7010309@web.de>
References: <4B684F5F.7020409@web.de> <20100203102915.GA25486@coredump.intra.peff.net> <4B696447.10803@web.de> <201002031412.53195.trast@student.ethz.ch> <4B699A45.7000905@web.de> <4B699C08.50400@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Feb 03 17:25:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nci29-0003F7-KS
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 17:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525Ab0BCQYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 11:24:48 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:50380 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932460Ab0BCQYr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 11:24:47 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 8858B14D0422C;
	Wed,  3 Feb 2010 17:24:46 +0100 (CET)
Received: from [78.54.162.123] (helo=[192.168.1.202])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nci20-00047m-00; Wed, 03 Feb 2010 17:24:45 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <4B699C08.50400@op5.se>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+Xd2TxDlHXzUcFekmXAnkBts/N0WN4zhZRG1/f
	ksOwGwtdcXb4Z1u79eBLq0Um8A0kpkw8+0q4ViDjepgrwmfr93
	kRltlUUsyPOP2P3+Ae0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138845>


>
> The general feeling on this list is that patches are listened to, no
> matter how foul they are, and you will get a (hopefully) polite
> rejection if it is considered useless because it addresses a problem
> that doesn't exist.
>   

I hope that a healthy balance will be found between correct software
design, development and quick "hacking". There might also be more
efforts if too many patches will be rejected just because the suggested
and planned changes were not discussed before.

Would you like to get an acknowledgement for signal handler problems
from people in other discussion groups like "comp.programming.threads"?

Regards,
Markus
