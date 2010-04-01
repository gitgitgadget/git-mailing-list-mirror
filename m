From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git branch -a prefixes origin/ branches with remotes/
Date: Thu, 01 Apr 2010 11:17:40 +0200
Message-ID: <4BB464B4.1080109@drmicha.warpmail.net>
References: <18137.1270056387@relay.known.net>	 <k2r76718491003311459u4bbaeb4ax5b2e550acdd14c88@mail.gmail.com>	 <m2iq8c2ln9.fsf@igel.home> <q2y76718491003311509z9c2f83c2t4a217f7c68b4ff4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>, layer <layer@known.net>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 11:17:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxGWl-000144-6x
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 11:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab0DAJRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 05:17:21 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41822 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754145Ab0DAJRT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 05:17:19 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C5F8EE9DD4;
	Thu,  1 Apr 2010 05:17:18 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 01 Apr 2010 05:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=+UlwKKI27fDwudkN2D/1+Z+BWbQ=; b=G607P9IHMFwpOwiRATsts1C8uKOVKW7YnpBzUJgnS1Z0mud3+BghwFbTlxgsLwbHI2RT1GIj1edB4xmZbePiHD8KKyE2VlauaXi5c2njr6zJBFIkwB4A8INXGSyeOg5pjqhfiQWyD8DRZH7GXFMXbOuK002JLxgCb7bRqB+/jbs=
X-Sasl-enc: f2t0dRYWLaDTAI04DukMjav9AZLF6+ea6cP36gh3MBPH 1270113438
Received: from localhost.localdomain (p3EE28F40.dip0.t-ipconnect.de [62.226.143.64])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 59D6D7B75;
	Thu,  1 Apr 2010 05:17:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <q2y76718491003311509z9c2f83c2t4a217f7c68b4ff4f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143724>

Jay Soffian venit, vidit, dixit 01.04.2010 00:09:
> On Wed, Mar 31, 2010 at 6:04 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> Jay Soffian <jaysoffian@gmail.com> writes:
>>
>>> (Note to git list: there should be a man page that has a single-line
>>> summary of each command and states whether the command is plumbing or
>>> porcelain. Maybe there is and I just don't know it.)
>>
>> git(1)
> 
> Yes, I'm an idiot. Anyone else wanna pile on? :-)

Just blame it on April fool's day, you fooled everyone who took your
remark seriously ;)

Michael
