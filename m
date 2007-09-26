From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add ability to specify SMTP server port when using git-send-email.
Date: Wed, 26 Sep 2007 09:18:17 +0200
Message-ID: <46FA07B9.4000402@op5.se>
References: <1190759927-19493-1-git-send-email-glenn@rempe.us> <7vabra2rv3.fsf@gitster.siamese.dyndns.org> <1A0CAB9D-5C99-4FD7-B3AC-9B3161FD8663@rempe.us> <Pine.LNX.4.64.0709260239210.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Glenn Rempe <glenn@rempe.us>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 09:18:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaRAD-0003XP-MD
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 09:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbXIZHSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 03:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbXIZHSW
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 03:18:22 -0400
Received: from mail.op5.se ([193.201.96.20]:33324 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482AbXIZHSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 03:18:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A651E194485;
	Wed, 26 Sep 2007 09:18:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KtL1GJbYB81G; Wed, 26 Sep 2007 09:18:19 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 0F709194443;
	Wed, 26 Sep 2007 09:18:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0709260239210.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59216>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 25 Sep 2007, Glenn Rempe wrote:
> 
>>> * The indentation was horrible.  Maybe your tabstop is set
>>>   incorrectly?
>> Can you be more detailed on the definition of 'horrible'? :-) I am using 
>> Textmate on OS X with soft tab stops (2 spaces).  What should it be to 
>> look less horrible on your end?  Or is the issue that I indent fewer 
>> tabstops than you expect? If so, sorry since perl is not my usual 
>> language and Ruby 2 space (soft tab) indentation looks right to my eye.
> 
> We use soft tabs, with the standard up-to 8 spaces,

Actually, the rest of git's perl-scripts use hard tabs, just as the C-code
and the shell-code, with tabs for indentation and spaces for alignment.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
