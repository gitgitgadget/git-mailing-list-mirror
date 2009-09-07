From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message configurable
Date: Mon, 07 Sep 2009 09:35:49 +0200
Message-ID: <4AA4B7D5.2090407@viscovery.net>
References: <20090906064454.GA1643@coredump.intra.peff.net>	<20090906064816.GC28941@coredump.intra.peff.net>	<7v8wgsk0rw.fsf@alter.siamese.dyndns.org>	<20090906072322.GA29949@coredump.intra.peff.net>	<7vzl98fr22.fsf@alter.siamese.dyndns.org> <20090907094457.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, Git <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 09:36:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkYm6-0007Cz-HT
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 09:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbZIGHgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 03:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbZIGHgV
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 03:36:21 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38164 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbZIGHgU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 03:36:20 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MkYlt-00015z-H6; Mon, 07 Sep 2009 09:36:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DDE9F735; Mon,  7 Sep 2009 09:36:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090907094457.6117@nanako3.lavabit.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127894>

Nanako Shiraishi schrieb:
> Quoting Junio C Hamano <gitster@pobox.com>
> 
>> Speaking of which, has anybody felt annoyed by this message?
>>
>>     $ git reset --hard HEAD^^
>>     HEAD is now at 3fb9d58 Do not scramble password read from .cvspass
>>
>> This is not "maybe you should try this", but I would consider that it
>> falls into the same "I see you are trying to be helpful, but I know what I
>> am doing, and you are stealing screen real estate from me without helping
>> me at all, thank you very much" category.
> 
> You may be fixated at the sha1 part of the message when you find this
> message annoying, but I disagree strongly. I always appreciate the assurance
> this message gives me that I counted the number of commits correctly,
> whether I say HEAD^^^^ or HEAD~7.
> 
> Showing the subject of the commit you are now at is very useful and I will
> be equally irritated as you do if it starts showing the subject of the
> commit I was at.

I agree 100% with your reasoning.

-- Hannes
