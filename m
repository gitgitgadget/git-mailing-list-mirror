From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Set OLD_ICONV on Cygwin.
Date: Tue, 04 Dec 2007 14:43:23 +0100
Message-ID: <4755597B.9050709@op5.se>
References: <21977191.137171196775591804.JavaMail.www@wwinf1621>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pascal Obry <pascal@obry.net>, Pascal Obry <pascal.obry@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pascal Obry <pascal.obry@wanadoo.fr>
X-From: git-owner@vger.kernel.org Tue Dec 04 14:43:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzY44-0002LG-46
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 14:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbXLDNnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 08:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752728AbXLDNnf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 08:43:35 -0500
Received: from mail.op5.se ([193.201.96.20]:54902 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346AbXLDNne (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 08:43:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EF9B71F08052;
	Tue,  4 Dec 2007 14:43:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vc1xoh5S37Ye; Tue,  4 Dec 2007 14:43:31 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 492E31F08004;
	Tue,  4 Dec 2007 14:43:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <21977191.137171196775591804.JavaMail.www@wwinf1621>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67044>

Pascal Obry wrote:
> Andreas Ericsson wrote:
>> Only one, insofar as I can see; You didn't CC Junio. He probably missed it.
> 
> Hum, I don't think this is a requirement. At least nothing is said about
> CCing Junio on the Git Web site.
> 

It's not a requirement, but he won't act on things he doesn't see, and CC'ing
him directly is the recommended way of getting his attention. Most people do
so for patches that aren't directly related to a sub-part of git primarily
maintained by someone else (Shawn O. Pearce for git-gui, Eric Wong for git-svn,
etc., etc.)

> Anyway, now Junio is CCed :)
> 

Nice. If my suspicions are correct and he missed your patch the first time
around, you should probably resend it though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
