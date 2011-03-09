From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix typo in t/README
Date: Wed, 09 Mar 2011 12:54:05 -0800
Message-ID: <7vbp1k9frm.fsf@alter.siamese.dyndns.org>
References: <4D77E225.8060009@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Wed Mar 09 21:54:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxQOi-0004h7-VO
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 21:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab1CIUyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 15:54:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1CIUyP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 15:54:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DADFB412A;
	Wed,  9 Mar 2011 15:55:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vltu0QvoIO0E+KdNWEVSbvW0/3o=; b=ckHoLk
	QAt9qclbrNL7y08u11GcAu0GyaAWizxCRO5vI6d5kaEXCj0orqJn6QPiqJMgmgiS
	2BoPh8D6qWbUrlyTYadvW55d+M6y7/MlFaMqOweA90UjAxFAwOWklJe0uFzj8xbp
	oHnU71LqKZbvDfA/tB6PBpbpel6EZoMg3EvgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vg1iR+FAs5EwXqbBKnGIQLJ8/58TFsMf
	uM5keDvDn/fxjRjRzfZ49j/zqVoqZjETGqo81uetCU9fBXo4966SpSpYXnCS2v1R
	Tq5RILk8z7hgGc9wOcthWLDhf77QFk6aq1C+nsAA7wfn+Wa2azFXaf7T4BKIOI1D
	NYoCMqOyhl4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B91734128;
	Wed,  9 Mar 2011 15:55:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D7758411C; Wed,  9 Mar 2011
 15:55:35 -0500 (EST)
In-Reply-To: <4D77E225.8060009@debugon.org> (Mathias Lafeldt's message of
 "Wed, 09 Mar 2011 21:25:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 967E2B90-4A8F-11E0-BB8F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168757>

Mathias Lafeldt <misfire@debugon.org> writes:

> Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
> ---
>  t/README |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/README b/t/README
> index 25f7d2d..78c9e65 100644
> --- a/t/README
> +++ b/t/README
> @@ -328,7 +328,7 @@ Keep in mind:
>  Skipping tests
>  --------------
>  
> -If you need to skip tests you should do so be using the three-arg form
> +If you need to skip tests you should do so by using the three-arg form
>  of the test_* functions (see the "Test harness library" section
>  below), e.g.:

Thanks.

Is it already "the international send-a-trivial-typofix-patch day" today?
