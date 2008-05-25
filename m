From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <poststelle@suesserott.de>
Subject: Re: Which msysGit version corresponds to which official Git version?
Date: Sun, 25 May 2008 17:59:24 +0200
Message-ID: <48398CDC.8070908@suesserott.de>
References: <48380E05.9020103@dirk.my1.cc>	<3F512BCF-1D2E-46B0-84E5-4807753A2618@zib.de>	<4839839C.2040605@dirk.my1.cc> <20080525173859.6d55ccc3@neuron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Krueger <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sun May 25 22:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0MTW-0005qh-Fx
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 22:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757523AbYEYUEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 16:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757137AbYEYUEf
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 16:04:35 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:48203 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978AbYEYUEe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 16:04:34 -0400
X-Greylist: delayed 14706 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 May 2008 16:04:34 EDT
Received: from [84.176.113.252] (helo=[192.168.2.100])
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <poststelle@suesserott.de>)
	id 1K0Id5-00074x-2g; Sun, 25 May 2008 17:59:27 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080525173859.6d55ccc3@neuron>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82878>

Jan Krueger schrieb:
> Hi,
>
>   
>> I'd expected that "HEAD is now at 9d8318051...". Wrong?
>> When I checkout "1d2375d" it says the very same:
>>   > HEAD is now at 1d2375d... GIT 1.5.5
>>     
>
> 9d831 is the v1.5.5 tag object; 1d237 is the commit it points to. When
> you pass a tag reference to checkout, it gets dereferenced to the
> corresponding commit.
>
>   
Ahh, that explains it. :-) Thanks! I sometimes mix up the different IDs 
Git emitts.
