From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix typos in man pages
Date: Wed, 05 Feb 2014 14:35:40 -0800
Message-ID: <xmqqk3d91937.fsf@gitster.dls.corp.google.com>
References: <1391638783-10686-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 23:36:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBB4e-0000gn-R4
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 23:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbaBEWfo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Feb 2014 17:35:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbaBEWfo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Feb 2014 17:35:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 300CA6743D;
	Wed,  5 Feb 2014 17:35:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cbWio2tmVtwe
	WgmqIhnAfYjukrw=; b=sJa7gmHUWXjzCz7p+wV4IEI7QcWNtBSlAV5hFnIofe9u
	MKJKJumu8MLMW/VfVtOh2MkhKMIPxudvwzuV7CeybyvIV+b7scyLlqNc02CbNQls
	uHED089/qXm1h0Ays2UhZQR/r0ct8GDVT0OsVBYWSq60UGz762+iMqSfpZwu+xU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KdsM4k
	DeInUZ0gWr7p7v87N2AMuf9SzV1TqcyxMtodpDcyOJEgZJz8JeH/jPjEwUHuIJXN
	rVD36BR1CLTr/cHOU2w7jhSnb8qPkmEMOEHo7WImnXQhT9wbM5/OnjCAbR9mxp2S
	pjayZW0duixx7DehwYQ/m8g+jKDe0VIANp9ZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1912D6743C;
	Wed,  5 Feb 2014 17:35:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B9736743B;
	Wed,  5 Feb 2014 17:35:42 -0500 (EST)
In-Reply-To: <1391638783-10686-1-git-send-email-oystwa@gmail.com>
 (=?utf-8?Q?=22=C3=98ystein?=
	Walle"'s message of "Wed, 5 Feb 2014 23:19:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D881838A-8EB5-11E3-A2AD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241670>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
>
> In July I sent in some typo fixes but it halted in a discussion on UK
> vs. US English and so forth ($gmane/231331). There were some actual t=
ypo
> fixes in there though (in addition to the "opinionated typo fixes").
>
> Powering up my old laptop for the first time in months I noticed that=
 I
> had them idling in a branch, and that incidentally none of them has b=
een
> fixed. Hopefully I've managed to seperate the genuine typo fixes from
> the rest.

Wonderful.

All of them looked fine. I however am already deep in today's
integration cycle, so it will appear in the public branches
tomorrow.

Thanks.
