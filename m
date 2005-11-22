From: Andreas Ericsson <ae@op5.se>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Tue, 22 Nov 2005 20:30:48 +0100
Message-ID: <438371E8.2030701@op5.se>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org> <200511210026.30280.Josef.Weidendorfer@gmx.de> <200511221831.03954.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 20:33:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eedqv-0005n8-T5
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 20:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbVKVTav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 14:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbVKVTav
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 14:30:51 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:24716 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S965144AbVKVTau
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 14:30:50 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id EDB996BCBE; Tue, 22 Nov 2005 20:30:48 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12568>

Johannes Schindelin wrote:
> 
> 	git-config-set --get remote.origin.url
> 

So... "git-config-set" is used for both getting and setting? Why not 
just "git-config --set" and "git-config --get" to make things a bit less 
confusing?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
