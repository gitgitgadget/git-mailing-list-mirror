From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Set OLD_ICONV on Cygwin.
Date: Tue, 04 Dec 2007 10:32:43 +0100
Message-ID: <47551EBB.8030504@op5.se>
References: <1196502562-1052-1-git-send-email-pascal@obry.net> <47544FC7.3070100@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Dec 04 10:33:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzU9N-00037h-5R
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 10:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbXLDJcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 04:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbXLDJcr
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 04:32:47 -0500
Received: from mail.op5.se ([193.201.96.20]:33084 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbXLDJcq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 04:32:46 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E9E201F08050;
	Tue,  4 Dec 2007 10:32:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BNKiSjZKd3+i; Tue,  4 Dec 2007 10:32:44 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 101C01F0804A;
	Tue,  4 Dec 2007 10:32:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <47544FC7.3070100@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67031>

Pascal Obry wrote:
> I pretty well understand that this patch is not very important but since
> I got no reply I'm wondering if there is something wrong with it ?
> 

Only one, insofar as I can see; You didn't CC Junio. He probably missed it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
