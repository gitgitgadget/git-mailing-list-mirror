From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add format-patch option --no-name-prefix.
Date: Tue, 18 Dec 2007 17:03:39 +0100
Message-ID: <4767EF5B.3010600@op5.se>
References: <1197992574-3464-1-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pascal@obry.net
To: Pascal Obry <pascal.obry@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:04:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4evO-0000k8-Px
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393AbXLRQDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 11:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756546AbXLRQDo
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:03:44 -0500
Received: from mail.op5.se ([193.201.96.20]:60123 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756305AbXLRQDn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 11:03:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0CA7A1F08049;
	Tue, 18 Dec 2007 17:03:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XgTlavWsSotW; Tue, 18 Dec 2007 17:03:41 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id B788A1F08043;
	Tue, 18 Dec 2007 17:03:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <1197992574-3464-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68768>

Pascal Obry wrote:
>  	int thread = 0;
> +	int no_name_prefix = 0;

Do we not need no double negations, yes?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
