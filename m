From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 16:26:40 +0100
Message-ID: <4BA397B0.2000908@drmicha.warpmail.net>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>	 <4BA338C1.7030803@alum.mit.edu>	 <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>	 <alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm>	 <20100319115445.GA12986@glandium.org>	 <3f4fd2641003190509j6e4908e4kab87b601d2ce9c00@mail.gmail.com>	 <b4087cc51003190516h42202e34k598a163c246cb9f2@mail.gmail.com> <3f4fd2641003190757y39050691y3dc0ca08bd5196fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>, Mike Hommey <mh@glandium.org>,
	david@lang.hm, git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 16:29:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nse8v-0001DY-31
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 16:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728Ab0CSP3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 11:29:30 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34332 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752105Ab0CSP33 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 11:29:29 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5CF37E8B5E;
	Fri, 19 Mar 2010 11:29:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 19 Mar 2010 11:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=HKwRpwP5KRYgLKOjcJ7WnjRg9l8=; b=gHCfI0JxEwZDy4bRCnHwVJQQ6QgejHhCJrCEP7S+mTD1MpyPfY+3r8TobBR0f2HAeeHZalOsxfdcjMB809srQW0jQygZeEjce/X9TaNNDf07NhrZzvmEZSien1HpvqyT3/3fRE8sOzkLyclLQ32y5/wveCNMy2n1mL000di1WHc=
X-Sasl-enc: Pu495Wiimreb5u5mFLGQCaA/ug87NZz76M264PVmve/S 1269012567
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 634CA20293;
	Fri, 19 Mar 2010 11:29:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <3f4fd2641003190757y39050691y3dc0ca08bd5196fb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142615>

Reece Dunn venit, vidit, dixit 19.03.2010 15:57:

[snip]
> 
> So, I'll ask again: what problems are you trying to solve that
> cannot be solved by mailmap?
> 
> - Reece

[Attention, conspiracy theories below!]

The problem seems to be that some people are interested in statistics,
so some are interested in consistent author information, but this
requires others (the authors) to maintain this information, at least on
large projects where this information cannot be kept consistent by a few
people. So, some people are looking for a way to enforce this on the
others... Of course, one could also rephrase this is as "help authors
maintain their authorship information in a consistent way" ;)

Michael
