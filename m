From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix typos in technical documentation.
Date: Mon, 01 Feb 2010 12:55:52 -0800
Message-ID: <7vaavsvfon.fsf@alter.siamese.dyndns.org>
References: <20100131132438.GD23605@gmx.de> <vpqsk9m5nt1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 01 21:56:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc3Jc-000279-Rz
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 21:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab0BAU4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 15:56:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348Ab0BAU4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 15:56:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5007B9641A;
	Mon,  1 Feb 2010 15:56:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gngNmirBxBBVdjqcSYumG+tH5z0=; b=gMaFww
	68Oeh+gE7pSl1TB7mEmMjW6r6H10OGGi9QMgRR+biMfUDwfY5dy3WY3augmnce10
	A3nORrbEzKsVKtDDP5XyQes313H5k9xC+irm4pASWAGF9B10p6/qlhXRjMzlQ0SM
	88eo6lobeAsshVzdFoB4qYF5i/C804uFw5rM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UYdChd8OFUtX/9SOyFnR+BMinw0oMeWg
	uLu9tPEzxzjwFR2hYGFeFOQwAnOXpAMxhIW5mtqyUhC8AglJxAgf/92Zu5pbLM3p
	eLdyifB/PRamP05QmQm+NBJavbe6H3JuAiXONAM04dcw5z7KUhhTuIfkz+GQWS8f
	z/9twTBax3Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1829696415;
	Mon,  1 Feb 2010 15:55:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ED8F96414; Mon,  1 Feb
 2010 15:55:54 -0500 (EST)
In-Reply-To: <vpqsk9m5nt1.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun\, 31 Jan 2010 15\:52\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 32667100-0F74-11DF-990A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138647>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:
>
>> Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
>> ---
>>
>> Hi there,
>>
>> stumbled upon a couple of these, then grepped for the rest
>> in Documentation/.
>
> Nice catches!

Yeah, applied.  Thanks.
