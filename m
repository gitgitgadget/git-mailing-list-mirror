From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git.txt: update description of the configuration mechanism
Date: Fri, 15 Feb 2013 09:18:28 +0100
Message-ID: <511DEF54.5040407@drmicha.warpmail.net>
References: <1360856214-934-1-git-send-email-Matthieu.Moy@imag.fr> <511D0D88.6010302@drmicha.warpmail.net> <vpqzjz6ampm.fsf@grenoble-inp.fr> <7v4nhe3joq.fsf@alter.siamese.dyndns.org> <vpqy5eq94rq.fsf@grenoble-inp.fr> <7vvc9u22p6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 09:18:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6GVP-0007gk-F7
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 09:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926Ab3BOIS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 03:18:27 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40924 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932900Ab3BOIS1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2013 03:18:27 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7EEEB20949;
	Fri, 15 Feb 2013 03:18:26 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 15 Feb 2013 03:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=lXAB6C5UXqHlykWHcjmOm3
	d7ds8=; b=NH9bZCPupI04vuHjQ6ukgg3V69L6IT4gLEwu+15Sfo/2KEbI0QgGwv
	Vy9W4NJQITj+goO6uOqM9FNqngGJnowucNtC/lr2zzYsgPpv9m93514splfWHA0h
	ISIyAY191pw+RG7xilMvA8tjBXgQLe+qaspJtlmJ18C9vgEecglh8=
X-Sasl-enc: q8eYhQYtp91Nrk3RSqq0wgZlLFX2SGMKpVitDp70Aofb 1360916306
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DC65E8E0456;
	Fri, 15 Feb 2013 03:18:25 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7vvc9u22p6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216342>

Junio C Hamano venit, vidit, dixit 14.02.2013 19:03:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> But the exact location of per-user and per-repository configuration
>>> files does not matter in this context and is best left to the
>>> git-config documentation.
>>
>> I'm OK with your version.
> 
> I already queued your original with one s/not/now/; perhaps I will
> redo it then.

Yes, I think the new version improves upon Matthieu's which was a good
start to begin with :)

Michael
