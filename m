From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] config.txt,diff-options.txt: porcelain vs. plumbing for
 color.diff
Date: Thu, 28 Apr 2011 09:47:33 +0200
Message-ID: <4DB91B95.2020308@drmicha.warpmail.net>
References: <7voc3sewpg.fsf@alter.siamese.dyndns.org> <24a6907cade7aedb51dc20ab5977603ca21e70bb.1303889849.git.git@drmicha.warpmail.net> <20110427090323.GA14849@elie> <7v7hafabsj.fsf@alter.siamese.dyndns.org> <7vliyv7djb.fsf@alter.siamese.dyndns.org> <20110427221215.GC18596@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 09:47:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFLx4-0005lW-Is
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 09:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385Ab1D1Hrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 03:47:37 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41348 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754150Ab1D1Hrg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 03:47:36 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 145D420886;
	Thu, 28 Apr 2011 03:47:36 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 28 Apr 2011 03:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=+Wt6tUk8O6WLRqAuGVcPJwEWG5s=; b=s7bOg6MxcZ/nFDMywHEmEhTItMeD6Tt7rphcjW0zbS56/g67pKxaQAB4FcdtvG25tsPfjxPxqKKA4Gq7AlM8mpZt9ud3p86KVrGgkYugxkVswWFKhx3OFOBgz6PQyuPJ9g/RUrSuF3DccqhUGPXOm+M0sWtb6vCui57H3OUmr1Q=
X-Sasl-enc: 7rTe6wvxQoOP8vmLNIaY/K4UyGOQab34UnbmmwiNEDDV 1303976855
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 754F3449775;
	Thu, 28 Apr 2011 03:47:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110427221215.GC18596@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172320>

Jonathan Nieder venit, vidit, dixit 28.04.2011 00:12:
> Junio C Hamano wrote:
> 
>> I'll queue the following.
> 
> Thanks; looks good.

Yep, thanks both of you!

Michael
