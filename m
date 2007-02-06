From: Andreas Ericsson <ae@op5.se>
Subject: Re: Deprecation/Removal schedule
Date: Tue, 06 Feb 2007 15:55:47 +0100
Message-ID: <45C896F3.5000007@op5.se>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 06 15:55:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HERjh-0007ZT-DR
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 15:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbXBFOzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 09:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbXBFOzu
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 09:55:50 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55954 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbXBFOzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 09:55:50 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id A4BDD6BCD0; Tue,  6 Feb 2007 15:55:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.1.4
Received: from [192.168.1.20] (unknown [192.168.1.20])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 71DF36BCCF; Tue,  6 Feb 2007 15:55:47 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38845>

Junio C Hamano wrote:
> 
> * git-lost-found
> 
>   Although it has served us well, I think it is about to outlive
>   its usefulness, thanks to the recent "reflog by default"
>   change.
> 

Nonono. Please no. This has saved me more times than I can even care
to remember. Especially whenever I'm teaching newcomers how to git.
I really wouldn't want to not have it there in case its needed and
some schmuck upgrades git and then loses something vital because he
forgot to enable the reflog on an old repo.

Does it add significantly to the maintenance burden?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
