From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git's database structure
Date: Tue, 04 Sep 2007 20:51:43 +0200
Message-ID: <46DDA93F.7050009@op5.se>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>	 <Pine.LNX.4.64.0709041816340.29009@reaper.quantumfyre.co.uk> <9e4733910709041030ye912369nd574a5f78d3f521b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 20:51:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISdV9-0004iM-O3
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 20:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbXIDSvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 14:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbXIDSvr
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 14:51:47 -0400
Received: from mail.op5.se ([193.201.96.20]:43895 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbXIDSvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 14:51:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0A97A1943F9;
	Tue,  4 Sep 2007 20:51:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wiok5NMEji6u; Tue,  4 Sep 2007 20:51:44 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 602FC1943B4;
	Tue,  4 Sep 2007 20:51:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <9e4733910709041030ye912369nd574a5f78d3f521b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57633>

Jon Smirl wrote:
> 
> I'm not proposing a change to data being stored in git, it is a
> proposal to consider the impacts of how this data has been normalized
> in the data store.
> 

But to what end?

We all *know* the impacts:
* Excellent performance at what it does now.
* Currently zero capability to replace google as the #1 search engine.

Since replacing google's db was never, and will never, be the goal of
git, what is it you wish to achieve? Seriously, I'm dying to know, so
please tell me. If you have already and I'm too daft to understand it,
humor me and reiterate :-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
