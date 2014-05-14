From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Wed, 14 May 2014 13:21:30 -0700
Message-ID: <xmqqha4sjelx.fsf@gitster.dls.corp.google.com>
References: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com>
	<53729b2150a84_34aa9e5304e0@nysa.notmuch>
	<xmqq38gdmhdo.fsf@gitster.dls.corp.google.com>
	<5372a0f6650d2_36c411ff3002e@nysa.notmuch>
	<5372D205.4040004@gmail.com>
	<xmqqppjgji2s.fsf@gitster.dls.corp.google.com>
	<5373c6668871b_56d6e3b30451@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 22:21:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkfgP-0006JY-JD
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 22:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbaENUVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 16:21:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53414 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbaENUVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 16:21:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF08A18A5C;
	Wed, 14 May 2014 16:21:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RZuvd68L1GpXpXhdrvw+0Ce7Ur0=; b=D9HKOM
	uXVels4oN4A9oKfJ9nAOS4r7s3czpf2emi+2jkeT8VB1Ai8ek0d1gDz/bvVAFvLm
	FgVmrSjkLlQFm6MnL7vuusl2pkLX6Dlw5Rr1fYKA5C6le2zqQAbn561Z3OwroXr5
	f9l99vfGFh77Bp2nUlPLrDiglgKYJasSHIIdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PwYWp2q6VdeGRDSKhIEbO2SQp66m8SQH
	Moo9dC6Nt2Ini2bQrdjSCGbRsdaR4hrSKM+o8QxlWNfifbK6atfJmLrJmOcXLC9E
	UkQ53JYc2XNaxdvONypw0hFvtqRo33ZgKaxQ3sR+j9iFuS1iV8Ks9RahJtqikG9u
	jYZWmsCWXXg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B33C718A5B;
	Wed, 14 May 2014 16:21:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2E32318A44;
	Wed, 14 May 2014 16:21:32 -0400 (EDT)
In-Reply-To: <5373c6668871b_56d6e3b30451@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 14 May 2014 14:39:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 56B44C92-DBA5-11E3-94D6-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248946>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> So at this point, I would have to say that the users of remote-hg is
>> taken hostage by its author.
>
> The users of remote-hg are being affected negatively *because* of your
> decisions.
>
> You have the power to help them by answering a simple question. Yet you
> refuse to do that.
>
> It's all on you.

That is exactly what I would call "taking users hostage".

I think I already answered that one question:

    I think after this insane amount of work I'm entitled to an answer for
    this *one* question.

    Instead you passive aggressively label me as a troll?

    This is really disquieting.

    Junio, do you honestly think I am a troll? Have at least the decency of
    telling it to me.

in $gmane/248853 with:

    You certainly are acting like one, aren't you?

Do you need more?
