From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add svnrdump
Date: Fri, 09 Jul 2010 10:16:51 +0200
Message-ID: <4C36DAF3.7090208@drmicha.warpmail.net>
References: <20100708083516.GD29267@debian> <002d01cb1e7f$e0ff03c0$a2fd0b40$@nl> <alpine.561.2.00.1007081113210.3936@daniel2.local> <4C36706E.7070400@orcaware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <bert@qqmail.nl>,
	'Ramkumar Ramachandra' <artagnon@gmail.com>,
	dev@subversion.apache.org, 'Jonathan Nieder' <jrnieder@gmail.com>,
	'Sverre Rabbelier' <srabbelier@gmail.com>,
	'Git Mailing List' <git@vger.kernel.org>
To: Blair Zajac <blair@orcaware.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 10:17:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX8mU-0003HF-QK
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 10:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab0GIIRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 04:17:52 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:35941 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753763Ab0GIIRt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 04:17:49 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0C5EB16847B;
	Fri,  9 Jul 2010 04:17:49 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 09 Jul 2010 04:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=4ZqUnMyNOynbeN//Uo7/hCB7h48=; b=WUY5fRptvsxLPMOxlP2Xl4WQ7j9AHlyxFxpL90Vkb/Uqjyu3ape++cYGqMzt+O80wKYLAtI/+A8V0YuD6jCMLelcE/bPZ6I70ineHIKxeG7tFtxFHJhxgnNcfsvIKkPEDFxpy3yG+KzZY8fEcs/xt44NjLnVEHJFNfRPlf8Kdv8=
X-Sasl-enc: AYi/cl9g0tThp01OaXsiECgWtry92WIywhlUgsx4CKE+ 1278663468
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 98D824E789B;
	Fri,  9 Jul 2010 04:17:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
Newsgroups: gmane.comp.version-control.subversion.devel
In-Reply-To: <4C36706E.7070400@orcaware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150647>

Blair Zajac venit, vidit, dixit 09.07.2010 02:42:
> On 07/08/2010 01:17 AM, Daniel Shahaf wrote:
>> @Bert: could you please trim quoted patches to only the relevant parts?
>> Scrolling is tedious when I don't have have line folding available...
> 
> +1 on this, in Thunderbird, it took a while to scan through the whole 
> email to see the comments.

<plug>
That is what the QuoteCollapse extension to Thunderbird was invented for. ;)
</plug>

In fact, on the git list we tend to trim as little as possible.

Michael
