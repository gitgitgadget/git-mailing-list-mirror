From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : git-send-email: threaded view issue with Thunderbird
Date: Thu, 24 Aug 2006 09:13:00 +0000 (GMT)
Message-ID: <20060824091300.7335.qmail@web25815.mail.ukl.yahoo.com>
References: <7v64gibjox.fsf@assigned-by-dhcp.cox.net>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 11:13:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGBGu-0007Jy-0j
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 11:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWHXJNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 05:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWHXJNE
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 05:13:04 -0400
Received: from web25815.mail.ukl.yahoo.com ([217.146.176.248]:34929 "HELO
	web25815.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750967AbWHXJNC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 05:13:02 -0400
Received: (qmail 7337 invoked by uid 60001); 24 Aug 2006 09:13:00 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=grdacsWdjS2qVS5Gqf0uslhHNLeu7QK9s4xTjj5rd4MyHwec7BcRJQUOWAnEt5D14jaL/LUuimEKTwtlC+5+XyP5PnFsX6tuQ/V5FTyVZibgeu5YcPYhgsGRqt4LEr5P0inA0F/tPUbAk1hZOX3Gw3VQjPJ/VeJFlqWa5QrGYWY=  ;
Received: from [194.3.162.233] by web25815.mail.ukl.yahoo.com via HTTP; Thu, 24 Aug 2006 09:13:00 GMT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64gibjox.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25952>

Junio C Hamano wrote:
> moreau francis <francis_moreau2000@yahoo.fr> writes:
> 
>> Hi,
>>
>> Sometimes, actually most of the time, git-send-email _seems_ to not
>> work properly with Thunderbird: for example if I send a patchset made
>> up by 4 single patchs, then Thunderbird show me this patchset 'broken'
>> that is [PATCH 2/4] is not shown as a reply to [PATCH 1/4].
>> ...
>> The strange thing is that all email headers are correct.
> 
> Then this is a wrong list perhaps ;-).
> 

yeah, that's why I wrote "git-send-email _seems_ to not work properly 
with Thunderbird". I actually think it's a Thunderbird issue, I'll
contact them hoping they won't tell me it's a git issue ;)

thanks

Francis
