From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/3] gitweb: Whitespace cleanup: realign, reindent
Date: Wed, 23 Aug 2006 11:07:04 +0200
Message-ID: <44EC1AB8.1090005@op5.se>
References: <200608221651.19629.jnareb@gmail.com> <200608221652.50443.jnareb@gmail.com> <7virkkjkvd.fsf@assigned-by-dhcp.cox.net> <ech55l$reh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 11:07:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFohr-0001hx-42
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 11:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWHWJHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 05:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWHWJHJ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 05:07:09 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:53736 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751464AbWHWJHH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 05:07:07 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 11BC16BD3F; Wed, 23 Aug 2006 11:07:05 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 172EA6BD2B; Wed, 23 Aug 2006 11:07:05 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ech55l$reh$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25901>

Jakub Narebski wrote:
> Junio C Hamano wrote:
> 
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> This patch tries (but no too hard) to fit gitweb source in 80 columns,
>>> for 2 columns wide tabs, and indent and align source for better
>>> readibility.
>> If you are doing the wrapping, which I think is a good idea, I
>> do not think you should target for an oddball setting.  Where
>> did you get the idea of 2-column tabs?
> 
> So what is the default? 5-column tabs? 8-column tabs? And to what width?
> 80-column wide? 120-column wide?
> 
> I use 2-column tabs to have code not too wide; minimal sensible width.

Default is 8-column tabs. BSD folks use (used?) 4 column tabs by 
default. I've never seen 2 column tabs, although GNU does 2-step 
indentation (they use spaces though, not tabs).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
