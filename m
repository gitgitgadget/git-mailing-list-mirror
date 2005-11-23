From: Andreas Ericsson <ae@op5.se>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Thu, 24 Nov 2005 00:29:37 +0100
Message-ID: <4384FB61.40506@op5.se>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>	<200511210026.30280.Josef.Weidendorfer@gmx.de>	<200511221831.03954.Josef.Weidendorfer@gmx.de>	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>	<438371E8.2030701@op5.se>	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de> <7viruj3q7z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 00:30:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef43a-0006E1-LO
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 00:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVKWX3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVKWX3k
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 18:29:40 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:40083 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751317AbVKWX3j
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 18:29:39 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 23DC16BCBE; Thu, 24 Nov 2005 00:29:38 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viruj3q7z.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12661>

Junio C Hamano wrote:
> 
> I somehow get a very funny feeling to see "git-XXXX --get"
> command that reports different things in different repositories
> (for obvious reasons) called git-config, and not
> git-repository-config.  But it probably is just me.
> 

git-repo-config is way friendlier for us poor lazy folks. That last 'y' 
in "repository" really breaks the flow.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
