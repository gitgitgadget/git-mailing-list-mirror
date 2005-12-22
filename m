From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add suggestion to hard-to-understand error message
Date: Thu, 22 Dec 2005 11:03:23 +0100
Message-ID: <43AA79EB.6040800@op5.se>
References: <Pine.LNX.4.63.0512220048360.13453@wbgn013.biozentrum.uni-wuerzburg.de> <7vd5jqvsn1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 11:03:46 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpNIX-0004Ie-6h
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 11:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbVLVKDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 05:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbVLVKDZ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 05:03:25 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:61568 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S965151AbVLVKDY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 05:03:24 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id CD60C6BD02; Thu, 22 Dec 2005 11:03:23 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5jqvsn1.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13938>

Junio C Hamano wrote:
> In a sense, both are "pull first?" situation, and it probably is
> more confusing to give different messages to the user in these
> two cases.  From the end-user point of view they are the same
> "remote is not strict subset.".
> 

In non-git'ish, does this mean "you're not up to date, so pull before 
pushing" ? If so, why not say so? I'm sure it could prevent a fair few 
problems for users (not least those new to scm's).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
