From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] t9159-*.sh: Don't use the svn '@<rev>' syntax
Date: Wed, 20 Jul 2011 15:29:52 +0200
Message-ID: <4E26D850.5030403@drmicha.warpmail.net>
References: <4E21D295.7020600@ramsay1.demon.co.uk> <7vvcuy82kn.fsf@alter.siamese.dyndns.org> <4E269B7E.5030906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>,
	Eric Wong <normalperson@yhbt.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jul 20 15:30:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjWqh-0005Ap-4G
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 15:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab1GTN34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 09:29:56 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39322 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751799Ab1GTN3z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 09:29:55 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8E496212DB;
	Wed, 20 Jul 2011 09:29:54 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 20 Jul 2011 09:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Ngc1tyLrQu+6010TXhlm/e
	Du8Ik=; b=dZrR4su1v5/x195fyrHHZqFXU1nJ0bvvLi/iLCIFVh7LOWWF4N7K9X
	k/w2grpcqhXj7dW3a7B2iewiyOAyaULvAvNs1Husj/b5DzhIDX+O5M+pB72ZG5zb
	eHjCf8/fL4uMQJ0j2+ZE8VKpDIj6i66FNWy5wZtmBdXiqEDd5hAxM=
X-Sasl-enc: fwWuaavYOWagFv1IMyL4Gw7e2YB8YRWdlM7w7T1xvlvA 1311168594
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 82408402F0A;
	Wed, 20 Jul 2011 09:29:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <4E269B7E.5030906@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177537>

Michael J Gruber venit, vidit, dixit 20.07.2011 11:10:
> And here's just a ping post with Sam's *correct* address so that he's

Or so I thought. Last try. Promised.

> not shut out but aware of the thread...
