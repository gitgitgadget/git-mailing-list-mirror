From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] New script: git-changelog.perl - revised
Date: Sat, 03 Nov 2007 09:36:25 +0100
Message-ID: <472C3309.70109@op5.se>
References: <67837cd60711021303q488e0873lea363b93fc90d591@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ronald Landheer-Cieslak <ronald@landheer-cieslak.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 09:36:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoEUo-0006o8-OS
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 09:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701AbXKCIgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 04:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756313AbXKCIgb
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 04:36:31 -0400
Received: from mail.op5.se ([193.201.96.20]:48315 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755463AbXKCIgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 04:36:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8590F17306D1;
	Sat,  3 Nov 2007 09:36:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HjvVKgXzlfqg; Sat,  3 Nov 2007 09:36:25 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id A9BE017306B9;
	Sat,  3 Nov 2007 09:36:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <67837cd60711021303q488e0873lea363b93fc90d591@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63219>

Ronald Landheer-Cieslak wrote:
>
> This is also available through git at
> git://vlinder.landheer-cieslak.com/git/git.git#topic/git-log-changelog
> 

This mode of specifying a repository + branch was just thoroughly shot
down in a list discussion, and git certainly doesn't grok it. I'd be a
happier fella if you didn't use it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
