From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Minor additions to git-completion.bash
Date: Sun, 28 Apr 2013 11:48:27 -0700
Message-ID: <7vvc76qyo4.fsf@alter.siamese.dyndns.org>
References: <1366549551-18763-1-git-send-email-artagnon@gmail.com>
	<CALkWK0mgfVNqOxaVY-JgKrzQe3rCJvaQuvp7frZKh7orRwdtig@mail.gmail.com>
	<CAMP44s1K9VYNbGFkec6mJ-xBZBafKvZqvu949DcVae12fuG9xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 20:48:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWWeI-0001uz-CA
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 20:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296Ab3D1Ssa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 14:48:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756155Ab3D1Ss3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 14:48:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DC1B1A84C;
	Sun, 28 Apr 2013 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9eIc5svREKy88p7tkXvDAu2CoOc=; b=Rs7iha
	21/YowXnPeH8uyD6nGHXmYyfsr+2d9dqeL/RhP/wltUTJfZFjfAnllNr0a5EUTr5
	+XQZiB34N3Qev7MMTuhj910hfju0kNoC+Y6pWte0fHVh+5p0rJhpDe6/nKX8U3EI
	lwh9imEsmDhrGlxCHnFuUee/+Dl2cejJWUBIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jm0xCjdcY+eqWU8uqw52BFvTDBwMI6Ot
	f8rfFFQtoxShhJuWlyFE6sy7jpZiKHH1S2I3UzisBcCpuJaRx4x1RGbHbzUTCwtK
	gSbX/A28RCnYUufvSd94GhpNYq82he9VsT71PNHIeuQWamuhlCwm+f/jY0VmNDTl
	kArHGB7zDCM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01C351A84A;
	Sun, 28 Apr 2013 18:48:29 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E5CB1A849;
	Sun, 28 Apr 2013 18:48:28 +0000 (UTC)
In-Reply-To: <CAMP44s1K9VYNbGFkec6mJ-xBZBafKvZqvu949DcVae12fuG9xA@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 26 Apr 2013 20:57:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3730841E-B034-11E2-ADE7-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222741>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Apr 24, 2013 at 2:49 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Ramkumar Ramachandra wrote:
>>> [...]
>>
>> Any updates on this?
>
> FWIW they all look OK to me.

I do not have the original series, so a resend with Felipe's Acked-by
after your original Sign-off would be nice.

Thanks.
