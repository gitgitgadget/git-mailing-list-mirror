From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Splitting the mailing list up
Date: Wed, 29 Sep 2010 11:08:17 +0200
Message-ID: <4CA30201.5020006@drmicha.warpmail.net>
References: <20100925230022.6e2fd389.coolzone@it.dk> <4CA1899F.2020509@cadifra.com> <141CAFB5-D423-48FE-BEED-B755C5F2685B@sb.org> <4CA2FA76.6080501@cadifra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, Rico Secada <coolzone@it.dk>,
	git@vger.kernel.org
To: Adrian Buehlmann <adrian@cadifra.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 11:08:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0se7-0003LM-25
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 11:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab0I2JIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 05:08:09 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:41476 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751600Ab0I2JIH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 05:08:07 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1DDE53DD;
	Wed, 29 Sep 2010 05:08:07 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 29 Sep 2010 05:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=XL3MM1qIRsp4xh2SSkOdEgHm2I4=; b=DJlbzZdJawER3hQhkq2RL+7QCWH0C/DN9//doWNw+pGU/ULozuE1xfAq6I/NLXACwqE+v2aT92MIrn2wlGgGTs2Ru71hVqLHiHY9n14BEkwcmIQxQQ5eBntAl622hkCRge/xgSrw3ptJmHg02ju54O3N0bz9Gw81TsccG2azfDY=
X-Sasl-enc: GK8LNUNsfohJkTACQeGFYVCChoDFzGcWxF9O0h9kiloA 1285751286
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 60681406722;
	Wed, 29 Sep 2010 05:08:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <4CA2FA76.6080501@cadifra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157548>

Adrian Buehlmann venit, vidit, dixit 29.09.2010 10:36:
> On 28.09.2010 22:06, Kevin Ballard wrote:
>> On Sep 27, 2010, at 11:22 PM, Adrian Buehlmann wrote:
>>
>>> I think this would definitely be an improvement for git users. At least
>>> splitting up into dev and user, like Mercurial does it too (which I am
>>> used to). Not sure about announce though.
>>>
>>> When I recently subscribed to this list (after having been a long time
>>> subscriber to the Mercurial lists too), I was interested in seeing
>>> discussions about git usage to help me get started with git.
>>>
>>> I also think searching the archives would be a bit easier if discussions
>>> of new git development details and its usage would be separated.
>>
>> Perhaps it would make more sense to simply create a new list for git
>> newbies to get help, and to not change the nature of this existing list
>> at all.
> 
> Of course, I would be fine if this list here would be simply defined as
> the "git development centric list" and a new, more usage-centric list
> could be started (git-users ?).

You mean something like:

git-users@googlegroups.com

I don't participate there, but my impression is that it's really a user
group.

FWIW: When I was new, the volume over here was too much for me also, and
simply filtering out all PATCH messages was a perfect solution. I've
removed that filter meanwhile, though...

Michael
