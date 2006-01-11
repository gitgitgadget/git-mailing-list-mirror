From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Wed, 11 Jan 2006 12:57:06 +0100
Message-ID: <43C4F292.7010404@op5.se>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>	<1136849810.11717.518.camel@brick.watson.ibm.com>	<7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>	<1136900174.11717.537.camel@brick.watson.ibm.com>	<43C3CC4A.4030805@op5.se>	<1136910406.11717.579.camel@brick.watson.ibm.com>	<7vzmm36f1x.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0601102054200.27363@wbgn013.biozentrum.uni-wuerzburg.de>	<1136925066.11717.605.camel@brick.watson.ibm.com>	<Pine.LNX.4.63.0601102200040.31923@wbgn013.biozentrum.uni-wuerzburg.de>	<43C44CF2.5050808@op5.se> <7v8xtn4m59.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 12:57:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwebH-0002MD-Qz
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 12:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWAKL5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 06:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWAKL5I
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 06:57:08 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:44185 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932393AbWAKL5I
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 06:57:08 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 0BA836BD03; Wed, 11 Jan 2006 12:57:07 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xtn4m59.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14484>

Junio C Hamano wrote:
> 
> True, but *please* stop calling "git wrapper" a potty.  It gives
> me an impression that it is not connected to the plumbing.
> 

Aww... And here I was being quite pleased with this wording in the man-page:

"The program git is just a wrapper to reach the core git programs (or  a 
potty if  you like, as it's not exactly porcelain but still brings your 
stuff to the plumbing)."

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
