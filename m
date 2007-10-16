From: Andreas Ericsson <ae@op5.se>
Subject: Re: How to Import a bitkeeper repo into git
Date: Tue, 16 Oct 2007 19:05:23 +0200
Message-ID: <4714EF53.8090707@op5.se>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>	 <20070709173720.GS29994@genesis.frugalware.org>	 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>	 <4713FA4A.5090501@bluelane.com>	 <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>	 <471433F3.40606@bluelane.com>	 <e5bfff550710152156t33ba10dam6171e3210c18d3ac@mail.gmail.com>	 <471454B5.7040802@bluelane.com> <e5bfff550710160211g5dbfa7fai95386b173edc45c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: pete@bluelane.com, Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:06:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhprU-0000CB-Vp
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778AbXJPRF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757740AbXJPRF2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:05:28 -0400
Received: from mail.op5.se ([193.201.96.20]:33060 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754379AbXJPRF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:05:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 917601730722;
	Tue, 16 Oct 2007 19:05:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ySMZt0+CIO7H; Tue, 16 Oct 2007 19:05:25 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 6C7E117306FD;
	Tue, 16 Oct 2007 19:05:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <e5bfff550710160211g5dbfa7fai95386b173edc45c3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61216>

Marco Costalba wrote:
> On 10/16/07, Pete/Piet Delaney <pete@bluelane.com> wrote:
> 
>> Would it be worthwhile
>> to install Qt4 from src and try to use qgit-2.0?
>>
> 
> Yes it is. There are a lot of new featrures, is almost as stable as
> the previous and if you are interested in file history (annotations)
> in qgit-2.0 this feature has been greatly speeded up.
> 

The only thing I really, really, really don't like about qgit4 is the
fact that it fudges up the commit-message. I've been trying for two
days to get rid of the HTML output, but I just can't get it done
without the signed-off-by email being enclosed in &lt;&gt; tags.

Marco, is there any chance you could make the old commit-message view
an option? Especially, the subject line should really, really be at the
bottom, with the rest of the message-text (although I liked the other
view without the colored box a lot more). The little arrows in the
commit window are also fairly annoying, as one quite quickly understands
that up-/down-arrows work much better for that sort of stuff anyway.

I'm at my wits end wrt c++ and qt, and can't for the life of me think of
how to make it an option :(

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
