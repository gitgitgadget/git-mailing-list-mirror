From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC 6/5] Documentation/format-patch: suggest Toggle Word
 Wrap add-on for Thunderbird
Date: Fri, 15 Apr 2011 20:01:35 +0200
Message-ID: <4DA887FF.4070606@drmicha.warpmail.net>
References: <87d3kq6tz7.fsf@rho.meyering.net> <1302719749.21047.6.camel@drew-northup.unet.maine.edu> <87mxjtn8x7.fsf@rho.meyering.net> <20110413221736.GA773@elie> <7vzkntkc9d.fsf@alter.siamese.dyndns.org> <20110414211125.GA15277@elie> <7vlizcfpz8.fsf@alter.siamese.dyndns.org> <20110415021100.GA19829@elie> <4DA7F6C0.4050707@viscovery.net> <7vtydzcse4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 20:01:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAnL0-0007VS-J3
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 20:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894Ab1DOSBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 14:01:41 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37127 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755639Ab1DOSBl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2011 14:01:41 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EB3ED2093D;
	Fri, 15 Apr 2011 14:01:39 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 15 Apr 2011 14:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=DS6gLRIqCS6jkEgKoOyTDpVxzl0=; b=Zv9KRjqkZx8mI3jO/AJKx+gvrp2xNmDw4d0jKf/gwB5DVG8uGpxuWvvP9c22gE545Jijv3Wm2aCEnny4x8++QXSKk2Nv0Z69KqbmakvisCTDjdhWzpQePFHMuIKxR2O+ILTV+imliwIaIXXfCT1zIzgbauBxli4J85BApgEEMpg=
X-Sasl-enc: 9QRxFTEqggtYST2esr9FF/Y01C2oxpSt0NIQUQZkQub7 1302890499
Received: from localhost.localdomain (p54859254.dip0.t-ipconnect.de [84.133.146.84])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B3CFC4456D5;
	Fri, 15 Apr 2011 14:01:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vtydzcse4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171626>

Junio C Hamano venit, vidit, dixit 15.04.2011 19:54:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> From: Johannes Sixt <j6t@kdbg.org>
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>  How about this as 6/5? I used the method described for this submission, so if
>>  what you got is unusable, you know what to think of the suggestion ;)
> 
> It seems to apply fine ;-).
> 
>>  I put this suggestion as approach #1 because I think it is superior to the
>>  other two (iff it worked).
> 
> Care to reword "superior" in a less subjective way (which should be very
> easy --- both existing suggestions seem to force plain-text no-wrap on any
> and all outgoing mails and to make it cumbersome to flip back and forth,
> as opposed to this one that gives a one-click on-demand way to do so only
> when you are sending a patch) and put it in the log message?

Does this add-on toggle "format fl[oa]wed" also? Otherwise you have to
make this is off also.

BTW: "AboutConfig" was great while it was needed, but these days you can
access Thunderbird's about:config from the options.

Michael
