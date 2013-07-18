From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Switch German translation to G+E
Date: Thu, 18 Jul 2013 12:37:00 -0700
Message-ID: <7vr4ev1wyr.fsf@alter.siamese.dyndns.org>
References: <1374040279-4828-1-git-send-email-ralf.thielow@gmail.com>
	<1374078276-3510-1-git-send-email-ralf.thielow@gmail.com>
	<87txjs6pdl.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>,
	Ralf Thielow <ralf.thielow@gmail.com>, <jk@jk.gs>,
	<stimming@tuhh.de>, <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 21:37:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzu0l-0004BJ-D1
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 21:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759317Ab3GRThF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 15:37:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759194Ab3GRThD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 15:37:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F45E32B66;
	Thu, 18 Jul 2013 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=miMScrNYmDLV2cG8awgwtRXNDw8=; b=BQe6Z4
	k0a5x4DTnxTUMZN8gvueGAqTROG5+YskKuOc1CUywW/gQKUVIlzNApSwIL0rU8NG
	aCxl237JQvBotNGSEJQAxqRjgQjh4Z1FCop27CzeMI9gKoBFzMIIKzgqtDdIvyWD
	5Z7kTA7PngSUr42RPpGD3lR4qxodAwtKdYeoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QPmybOEH7c5EXl5B5pOJkCLDrFc/2c6y
	ECc6cpJAI0XY6ymNoihq5xXq+EsoB1zXLoIfVZxejMamXiaiWaR07gsnzrVSxP98
	ZZ3TAvti+l+bNOtVSddc7Iysc0c38jMzs09ebmxABct66rGDV2+5UVS7wfKPTYDL
	tqRqHDzX6YM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 237E232B65;
	Thu, 18 Jul 2013 19:37:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A4E832B62;
	Thu, 18 Jul 2013 19:37:02 +0000 (UTC)
In-Reply-To: <87txjs6pdl.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Thu, 18 Jul 2013 14:09:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B8589A2-EFE1-11E2-B049-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230731>

Thomas Rast <tr@thomasrast.ch> writes:

> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> This is a resend of v3 because at least one patch was
>> damaged last time for whatever reason.
>>
>> Ralf Thielow (3):
>>   l10n: de.po: switch from pure German to German+English (part 1)
>>   l10n: de.po: switch from pure German to German+English (part 2)
>>   l10n: de.po: switch from pure German to German+English (part 3)
>
> Thanks, this one applied cleanly.
>
> Acked-by: Thomas Rast <trast@inf.ethz.ch>

Let's make sure our i18n coordinator is aware of this effort.

Thanks.
