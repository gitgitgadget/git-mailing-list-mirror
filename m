From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 3/5] Unify whitespace checking
Date: Thu, 13 Dec 2007 14:40:50 +0100
Message-ID: <47613662.6010203@op5.se>
References: <1197552751-53480-1-git-send-email-win@wincent.com> <1197552751-53480-2-git-send-email-win@wincent.com> <1197552751-53480-3-git-send-email-win@wincent.com> <1197552751-53480-4-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 14:42:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2oKn-0007SJ-5l
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 14:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756990AbXLMNlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 08:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbXLMNlj
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 08:41:39 -0500
Received: from mail.op5.se ([193.201.96.20]:47835 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbXLMNli (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 08:41:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 845721F08053;
	Thu, 13 Dec 2007 14:41:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3WrpY4MQJgFE; Thu, 13 Dec 2007 14:40:52 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id D5E5F1F08020;
	Thu, 13 Dec 2007 14:40:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <1197552751-53480-4-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68151>

Wincent Colaiuta wrote:
> 
>  - the emit_line_with_ws() function is also removed because that also
> rechecks the shitespace, and its functionality is rolled into ws.c
> 

shitespace? It's fitting though. I'd stick with it :-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
