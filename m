From: Andreas Ericsson <ae@op5.se>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Wed, 21 Nov 2007 16:53:55 +0100
Message-ID: <47445493.9000806@op5.se>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <4743E1D6.4010308@viscovery.net> <Pine.LNX.4.64.0711211209080.27959@racer.site> <47444A1B.4000907@op5.se> <Pine.LNX.4.64.0711211546410.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 16:54:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuruJ-0000GQ-0w
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 16:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbXKUPyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 10:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbXKUPyH
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 10:54:07 -0500
Received: from mail.op5.se ([193.201.96.20]:44651 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbXKUPyG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 10:54:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A056A1F08033;
	Wed, 21 Nov 2007 16:54:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3MifZzht+M3V; Wed, 21 Nov 2007 16:54:02 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id AF38A1F08025;
	Wed, 21 Nov 2007 16:54:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <Pine.LNX.4.64.0711211546410.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65668>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 21 Nov 2007, Andreas Ericsson wrote:
> 
>> Johannes Schindelin wrote:
>>> P.S.: I'll try to read up on ptrint_t, as suggested by Shawn.
>> I can't find a reference to ptrint_t anywhere on either my system,
>> and the 10 first hits on Google finds it on typedef lines, most
>> commonly like this:
>>
>> 	typedef unsigned long ptrint_t;
> 
> It is really called intptr_t, and it is C99.
> 

That'd explain it I guess. Thanks for the clarification.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
