From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Disclaimer about the number of slots.
Date: Wed, 04 Mar 2015 11:55:31 -0800
Message-ID: <xmqqk2yw8rm4.fsf@gitster.dls.corp.google.com>
References: <1425453571-8771-1-git-send-email-Matthieu.Moy@imag.fr>
	<1425453571-8771-2-git-send-email-Matthieu.Moy@imag.fr>
	<20150304075109.GC28502@peff.net> <vpq1tl5urfs.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 04 20:55:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTFON-0001aH-87
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 20:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758644AbbCDTzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 14:55:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757219AbbCDTze (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 14:55:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A99FB3C4CA;
	Wed,  4 Mar 2015 14:55:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hv8Unq8JXIEUbcgPzPUArIrwDBM=; b=PKN/rW
	XhmDEI67/29IJpWhcN+Fz9w+CFoxjOEQEgEn+JsxK4JQpfSRJSP1I8PrQIfzLy6n
	D+QxIxuEuEAV/nJF6i1WY+2y4iDuJsPf7GXeNt/G7uAF4qfY+SG3HnBM/m5nlMWr
	SOMTI/htiEZJXSdnkv/fbUnwuwBwlMcuF0Gf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rU0JNTA3em36hY1oMbcN9xnSt7RGT1Yh
	BTmBOZNIyHmmYgLM5AmYlOP99Gwzn8zX1sOI+dOodF7zvjmyNz5UyNZ0FUKW0jFi
	MXuntLKO4vYI1VjeqMs9r5w3G35fBYsKAVNOMAfqF35Bwe5/hVuiei7IiEcOW9xZ
	AFMB94H/2Mk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F21B3C4C3;
	Wed,  4 Mar 2015 14:55:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46E903C4BC;
	Wed,  4 Mar 2015 14:55:32 -0500 (EST)
In-Reply-To: <vpq1tl5urfs.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	04 Mar 2015 08:56:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A61653C-C2A8-11E4-9E56-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264770>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jeff King <peff@peff.net> writes:
>
>> Maybe something along the lines of "If you are really excited about
>> working on git, we would love to see your application; if you are just
>> looking for a random project, there may be a lot of competition for a
>> small number of slots". Except I am not quite sure how to phrase "just
>> looking for a random project" that does not sound quite so demeaning.
>
> Yes, that's the idea, but I didn't find a way to say "if you're one of
> the great students we're looking for, please come in, otherwise go
> away", so I went for a neutral wording that would let the reader infer
> it by themselves ;-).

What is this?  Matt and Jeff's comedy hour?

You two made me laugh hard ;-)
