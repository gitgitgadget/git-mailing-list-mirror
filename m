From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Error: Unable to append to logs/HEAD: Permission denied
Date: Mon, 17 May 2010 13:40:01 +0200
Message-ID: <4BF12B11.2090002@drmicha.warpmail.net>
References: <1274051912050-5063068.post@n2.nabble.com> <4BF0F63A.1080005@drmicha.warpmail.net> <1274084247216-5064104.post@n2.nabble.com> <4BF10623.5000705@drmicha.warpmail.net> <1274094574729-5064574.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git_user101 <m.aqadjanimemar@student.ru.nl>
X-From: git-owner@vger.kernel.org Mon May 17 13:40:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODygQ-0002Al-17
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 13:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab0EQLkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 07:40:23 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43560 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754664Ab0EQLkX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 07:40:23 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 84AA7F640B;
	Mon, 17 May 2010 07:39:54 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 17 May 2010 07:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=WhymJTRPohE+1uwufyzdMkP7al4=; b=mgorvaPuimyRUm+a3VnDSv77QuwDu84XNDFm3DrBNAtjcYvv3RgDRS3e4ucUI9XWdDSbFRAPMbQlbtgs9pZnWoVJ2Hg6f3UW2ZODgHYj0yzzVciIHS5hnJI3MoGpf5McdUkemRg3YD4FQ71eUMi0dQfnbaAvSkX+zdrQ/aw6M48=
X-Sasl-enc: e6BKSQui2WRRD8pwS/wX3VmgFQ29Owu5zPJxAE+D01TG 1274096394
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 638DA55068;
	Mon, 17 May 2010 07:39:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <1274094574729-5064574.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147225>

git_user101 venit, vidit, dixit 17.05.2010 13:09:
> 
> after configuring git and setting core.sharedRepository to true at server
> side, I do not get the first error any more. But the second one still
> appears on the screen after every push.
> error: failed to push some refs to 'ssh://remote server'
> 

That means that in addition to the 1st part, you'll also have to follow
the 2nd part of my advice ;)

Michael
