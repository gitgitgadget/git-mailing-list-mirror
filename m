From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 0/5] More builtin-fetch fixes
Date: Tue, 18 Sep 2007 12:16:19 +0200
Message-ID: <46EFA573.7080209@op5.se>
References: <20070918085444.GN3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 12:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXa88-0001XL-WC
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 12:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbXIRKQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 06:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753790AbXIRKQY
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 06:16:24 -0400
Received: from mail.op5.se ([193.201.96.20]:33411 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390AbXIRKQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 06:16:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8B8A519445E;
	Tue, 18 Sep 2007 12:16:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DWrGryiGEjQZ; Tue, 18 Sep 2007 12:16:20 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id DAC72194421;
	Tue, 18 Sep 2007 12:16:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <20070918085444.GN3099@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58569>

Shawn O. Pearce wrote:
> but for some of the really common cases we are quite
> happy with builtin-fetch.  Especially its performance as we're
> seeing speedups of 25x or more on Cygwin/Windows.
> 

Excellent news, and great job. :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
