From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Apology/Bug report: git-send-email sends everything on Ctrl+C
Date: Wed, 26 May 2010 11:16:13 +0200
Message-ID: <4BFCE6DD.4030403@drmicha.warpmail.net>
References: <4BFCB9D0.3010400@vilain.net> <4BFCC4B5.6070408@vilain.net> 	<1274861112.2074.2.camel@wpalmer.simply-domain> <4BFCE12E.4070009@vilain.net> <AANLkTin51a4RONmN6j3GXGJQ3UtE8bt3e_PF5t75mZTC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, Will Palmer <wmpalmer@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 11:16:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHCj9-0005Do-3N
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 11:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328Ab0EZJQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 05:16:33 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:50645 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932536Ab0EZJQc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 05:16:32 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 82F3FF80F6;
	Wed, 26 May 2010 05:16:29 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 26 May 2010 05:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=IPq+9SYZJHOZZLu+PHNLZJkkyFg=; b=a9Dl0i1K+LsXU1nYIzX1mRvdHxrqxAn5OlfJ4lzPWbFxvhqbuI1dZxFg3Y3rF4SVTh7Q0WeofTMbxxg/pq4wGau0B/CIPyZgWa5AuLf6YUQOzWlTXlNJUX6nnshfbgt47fkB3s77OPZmkym8i3YwzNAb7/cpVwhBH+wCfWnLnwg=
X-Sasl-enc: bYc7FzpBChyIYVQxQWey5cRSErwrojW7kVf8Ecc/wJqo 1274865389
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A301847518;
	Wed, 26 May 2010 05:16:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTin51a4RONmN6j3GXGJQ3UtE8bt3e_PF5t75mZTC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147788>

Sverre Rabbelier venit, vidit, dixit 26.05.2010 11:07:
> Heya,
> 
> [sorry for my earlier reply to your other accidental mail, feel free
> to ignore it as I had not read this thread yet]
> 
> On Wed, May 26, 2010 at 10:51, Sam Vilain <sam@vilain.net> wrote:
>> Hard to know what could have possibly stopped this from happening.  PEBKAC.
> 
> Perhaps git can be smart and ask for confirmation for huge (>20 ?) patchsets.
> 

to be overriden by an option "--no-villain"...

Sorry, bad joke, but couldn't resist. Feel free to pick on my name ;)

Michael
