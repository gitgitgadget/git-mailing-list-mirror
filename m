From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-send-mail in sh
Date: Fri, 25 Nov 2005 15:25:28 +0100
Message-ID: <43871ED8.9040506@op5.se>
References: <4386DD45.6030308@op5.se> <Pine.LNX.4.63.0511251200190.30119@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 15:26:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfeW9-00074k-9O
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 15:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbVKYOZa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 09:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbVKYOZa
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 09:25:30 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:31134 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161090AbVKYOZ3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 09:25:29 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 9A7836BCBE; Fri, 25 Nov 2005 15:25:28 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511251200190.30119@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12740>

Johannes Schindelin wrote:
> 
>>Sorry about the attachment btw. Thunderbird seems to wrap lines no 
>>matter what I tell it.
> 
> 
> The hints in SubmittingPatches did not help?
> 

Nopes. Perhaps because I started editing the message before I changed 
the settings. I'll investigate further and make amendments if necessary.

> 
>>Thoughts? Comments?
> 
> 
> I find it very cool. And easy to read. Just a few nits: You could use 
> git-sh-setup.sh to ensure that you're in a valid git repository. Also, you 
> could reuse the "die" function contained therein instead of a new 
> function, "abort".
> 

Will do. Thanks for the feedback.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
