From: Andreas Ericsson <ae@op5.se>
Subject: Re: more merge strategies : feature request
Date: Mon, 01 Dec 2008 10:18:59 +0100
Message-ID: <4933AC03.6050300@op5.se>
References: <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 10:21:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L74xx-0001WM-BY
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 10:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbYLAJT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 04:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbYLAJT7
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 04:19:59 -0500
Received: from mail.op5.se ([193.201.96.20]:59387 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbYLAJT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 04:19:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 23CAA1B80072;
	Mon,  1 Dec 2008 10:16:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DYWzV9TC0GNA; Mon,  1 Dec 2008 10:16:13 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 240A71B818D3;
	Mon,  1 Dec 2008 10:15:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
In-Reply-To: <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102007>

Caleb Cushing wrote:
> conflict: this strategy would always resolve in a merge conflict
> allowing you to use git mergetool to piece the files back together.
> 
> no-overwrite: if a change from the branch being merged in would
> overwrite something in the current branch don't merge it. (I think it
> needs a better name)
> 

If you could come up with use-cases where each would be useful, I
think you'd have a much easier time to gain acceptance for your
suggestions. Right now, you're saying "I want a red button" but
you're not explaining what it's for.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
