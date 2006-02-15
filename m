From: Andreas Ericsson <ae@op5.se>
Subject: Re: several quick questions
Date: Wed, 15 Feb 2006 01:08:21 +0100
Message-ID: <43F270F5.7070804@op5.se>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org> <87fymlvgzv.wl%cworth@cworth.org> <200602142230.11442.Josef.Weidendorfer@gmx.de> <7v7j7xr54u.fsf@assigned-by-dhcp.cox.net> <43F26129.4040804@op5.se> <Pine.LNX.4.63.0602150022470.24570@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 01:08:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9ADa-0004tT-DB
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 01:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422896AbWBOAIX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 19:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422897AbWBOAIX
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 19:08:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:28035 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1422896AbWBOAIW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 19:08:22 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 4B9666BCFF; Wed, 15 Feb 2006 01:08:21 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602150022470.24570@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16194>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 15 Feb 2006, Andreas Ericsson wrote:
> 
> 
>>What's the point of having another protected name. Just allow
>>
>>	$ git checkout -b discard HEAD~15
>>
>>and we're good to go.
> 
> 
> Last time I checked (2 hours ago) it did exactly what you want it to.
> 

Heh. You're right. :) Didn't grok that from the man-page. I'm so used to 
seeing <commit-ish> everywhere that when it says "<branch> can be any 
object that refers to a commit" I get confused.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
