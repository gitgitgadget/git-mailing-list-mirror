From: Andreas Ericsson <ae@op5.se>
Subject: Re: Problem merging
Date: Fri, 25 Nov 2005 02:35:13 +0100
Message-ID: <43866A51.4070109@op5.se>
References: <20051123025001.15527.qmail@web31812.mail.mud.yahoo.com> <7v4q6483ms.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511231546330.8191@wbgn013.biozentrum.uni-wuerzburg.de> <D8B7EF65-9D0C-4706-B248-4B7C118C16BF@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 25 02:37:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfSUy-0004Jk-Rb
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 02:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbVKYBfR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 20:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbVKYBfQ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 20:35:16 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:43675 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161082AbVKYBfP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 20:35:15 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 32C916BCBE
	for <git@vger.kernel.org>; Fri, 25 Nov 2005 02:35:14 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <D8B7EF65-9D0C-4706-B248-4B7C118C16BF@hawaga.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12725>

Ben Clifford wrote:
> hmm... pigeon-hole principle is just that there exists two files that  
> have the same SHA-1 as each other... doesn't say anything about *all*  
> SHA-1s, though?
> 

It doesn't have to say that explicitly. It's universally applicable to 
all static-size checksum algorithms given an infinite amount of inputs.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
