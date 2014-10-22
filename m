From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] .mailmap: Add Stefan Bellers corporate mail address
Date: Wed, 22 Oct 2014 15:03:20 -0700
Message-ID: <xmqqbnp3u5hz.fsf@gitster.dls.corp.google.com>
References: <1413856245-5443-1-git-send-email-stefanbeller@gmail.com>
	<1413856245-5443-2-git-send-email-stefanbeller@gmail.com>
	<xmqqppdm0y02.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYNvQOKLZ5qgCD1NyYG8X2q7UCr5rMbrxW6ajRAnFRz7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <stefanbeller@gmail.com>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 00:03:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xh40A-0000md-1J
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 00:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870AbaJVWD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 18:03:26 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932540AbaJVWDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 18:03:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DC9D17DA5;
	Wed, 22 Oct 2014 18:03:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FjIrGD3ruWVAk7JWgl17xpyM8xQ=; b=d1ef11
	4dFkXXsW3zoGHSudg1uLMworsnOfrCeuMtp3TARJ3mdLciPpxXBML5ScxAp+tP4K
	abNAvW+A91xd9zPvhHLMktcMfDH7kACb8N5E9HhzD6Se7UC52DDO7Pa9P4gs2Ml0
	3uqV3XbkfciI8MWFiluEfxjRkgIym7O/wyy+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PoYB/HaRnbVysBkfz2XpyYZ0UxP6+wi1
	wVkKJLcRAHBSPFvlQTbT/DWhqpz90kpoXHs83Gco2zx0GYmKZnnXJmqqSLFT8Cth
	NCfSqV4rL1ExWk62m8j+9gNcGzcQYthsQUi89ymQC2Shi6atStKMW8bEa49taO2J
	/cWL9ddyBS4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 155D417DA4;
	Wed, 22 Oct 2014 18:03:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D50017DA3;
	Wed, 22 Oct 2014 18:03:21 -0400 (EDT)
In-Reply-To: <CAGZ79kYNvQOKLZ5qgCD1NyYG8X2q7UCr5rMbrxW6ajRAnFRz7A@mail.gmail.com>
	(Stefan Beller's message of "Tue, 21 Oct 2014 10:54:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CA73EFC-5A37-11E4-ACBD-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> If you want me to continue using my gmail address, please check the
> authorship
> from the previous patch ([PATCH 1/2] transport: Free leaking head in
> transport_print_push_status)
> and remove the "From: Stefan Beller <sbeller@google.com>" line,
> so we don't end up needing this patch.

As I said, I do not care too deeply either way.  If you feel that
switching to a different e-mail address to sign off your patches
from now on until your employment is terminated has merit to the
project, that's fine by me.

Thanks.
