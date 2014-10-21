From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] .mailmap: Add Stefan Bellers corporate mail address
Date: Mon, 20 Oct 2014 22:53:33 -0700
Message-ID: <xmqqppdm0y02.fsf@gitster.dls.corp.google.com>
References: <1413856245-5443-1-git-send-email-stefanbeller@gmail.com>
	<1413856245-5443-2-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 07:53:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgSO9-0003sl-HC
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 07:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbaJUFxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 01:53:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751409AbaJUFxk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 01:53:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D77CD127EB;
	Tue, 21 Oct 2014 01:53:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=skk6lj8mJtrQQhsYZhptbAosUMc=; b=vde3xW
	8CfJY6CRmQDwotZn9rD+VwUwMPcWUdEN+fRhb4Eyvf6/SEfvlMN2CopEAdiuvCTL
	aZp/7ThmPB4M2DMWPdF1Wvguan/rLG3lli2xIoYnwzgGUaYwX7X+5fyB+Q5+v/W6
	Pb2FBGPInSq+LulfKIdXqoDEWNAd4T8gVrNFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=twbfor2UrrOIUeDLGDGlAuUBRNIMqGdi
	0wi/rgBNTAARPrD2h5B+wURH2lfGqkicEunIa/DPtYhM6y8Au7nbt8ktFJzGue/g
	Qp5CdJD8Ch5XIK03AfJ04FZW5xsN2jfnsHp9BkPY/prCtwUCxJBpBSPBGJdUpRz2
	6RoLlIEhPjA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE4C0127EA;
	Tue, 21 Oct 2014 01:53:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5945B127E8;
	Tue, 21 Oct 2014 01:53:34 -0400 (EDT)
In-Reply-To: <1413856245-5443-2-git-send-email-stefanbeller@gmail.com> (Stefan
	Beller's message of "Mon, 20 Oct 2014 18:50:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 97FEF4F4-58E6-11E4-8DC4-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <stefanbeller@gmail.com> writes:

> From: Stefan Beller <sbeller@google.com>
>
> Note that despite the private address being first, Google owns the
> copyright on this patch as any other patch I'll be sending signed off
> by the sbeller@google.com address.

While Googlers are encouraged to interact with external open source
projects using their corp address when working as new contributors,
Googlers are also encouraged to keep using the same pre-corp address
when working with projects they have been part of for continuity.

After all, even if you send patches from your @gmail.com address
while being employed by Google, the patches are copyright Google,
not yours, and DCO (a) "I have the right to submit" covers your
submissions just fine (i.e. it does not say "I own the copyright"),
as long as you are cleared to contribute your patches to us by
Google's open source office (which I happen to know that you have
already done).

The mailmap is primarily to correct past mistakes and document the
new addresses of those who lost the old address to maintain their
reachability.  It is not about planning to send patches from two
different addresses chosen by the phase of the moon or something.

I do not terribly mind, but is this patch really necessary?

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 8aefb5a..bb6f52e 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -205,6 +205,7 @@ Shawn O. Pearce <spearce@spearce.org>
>  Simon Hausmann <hausmann@kde.org> <simon@lst.de>
>  Simon Hausmann <hausmann@kde.org> <shausman@trolltech.com>
>  Stefan Beller <stefanbeller@gmail.com> <stefanbeller@googlemail.com>
> +Stefan Beller <stefanbeller@gmail.com> <sbeller@google.com>
>  Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@atlas-elektronik.com>
>  Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@googlemail.com>
>  Stefan Sperling <stsp@elego.de> <stsp@stsp.name>
