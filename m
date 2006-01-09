From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] format-patch: Use --mbox by default.
Date: Mon, 09 Jan 2006 03:05:11 +0100
Message-ID: <43C1C4D7.7060107@op5.se>
References: <20060108140109.909925BE8D@nox.op5.se> <43C18EE1.4050807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 09 03:05:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvmPP-0008Cy-Nz
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 03:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWAICFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 21:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWAICFO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 21:05:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:44677 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751293AbWAICFM
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 21:05:12 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 57EBC6BCBE; Mon,  9 Jan 2006 03:05:11 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43C18EE1.4050807@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14347>

H. Peter Anvin wrote:
> Andreas Ericsson wrote:
> 
>>
>> The patches generated also had bad mail headers for sendmail (of
>> postfix 2.2.2 at least) to use directly (From: line must be on top,
>> Subject: last of header)
> 
> 
> Sounds like a bug report against postfix is in order.
> 

No need. It works with 2.2.8. The 2.2.2 it failed with is the default 
for FC4. I have no interest investigating all the possibilities, and I 
doubt Vietse will look for bugs in old versions unless they're security 
related.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
