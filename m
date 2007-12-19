From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git show <tag>: show the tagger
Date: Wed, 19 Dec 2007 10:11:16 +0100
Message-ID: <4768E034.1040903@op5.se>
References: <Pine.LNX.4.64.0712181800250.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 10:11:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4uxx-0005Sa-FJ
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 10:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbXLSJLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 04:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbXLSJLV
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 04:11:21 -0500
Received: from mail.op5.se ([193.201.96.20]:58678 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbXLSJLU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 04:11:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A3BDF1F0804B;
	Wed, 19 Dec 2007 10:11:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C0RDphXg4iEj; Wed, 19 Dec 2007 10:11:17 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 6DACA1F08049;
	Wed, 19 Dec 2007 10:11:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <Pine.LNX.4.64.0712181800250.23902@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68869>

Johannes Schindelin wrote:
> For commit objects, the Author is shown, so do the equivalent for
> tag objects, too.
> 

That's funny. I tried to apply this onto my "patches" branch and got
conflicts. I have a near-identical one there that I forgot about
~6 months back, so

Acked-by: Andreas Ericsson <ae@op5.se>

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
