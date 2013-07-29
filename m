From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More typofixes.
Date: Mon, 29 Jul 2013 12:32:05 -0700
Message-ID: <7vvc3tyxfu.fsf@alter.siamese.dyndns.org>
References: <20130729081821.GA6758@domone.kolej.mff.cuni.cz>
	<51F6826D.2010606@xiplink.com>
	<7vob9l1d2s.fsf@alter.siamese.dyndns.org>
	<7vk3k91cfy.fsf@alter.siamese.dyndns.org> <51F6B610.70906@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>,
	git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 21:32:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3tB0-00084I-HF
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 21:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab3G2TcJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 15:32:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45201 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864Ab3G2TcI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jul 2013 15:32:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 583FB342BE;
	Mon, 29 Jul 2013 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uZEIUMWq3pFq
	4l5pHnyT+2Afzqw=; b=NkJw0p4S/FBVyTrQZPAHYy4svogXiOrUDdulFKsMsGqi
	3fdGrZTZVgKfIslnR+SLYcEIq7MB/QJpIx4gbaJg3wsmoicG/3qnFTmpZ03cdCpj
	0wrbglV5sp0/oLRIcQviMdSHIomuEGgk5BQbBvqj9s4ZEw1KlvgB83JUOJLHP7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kx7uCM
	9U0brivLixycXT6NWzGf9dTH7AwBM52TakAOsULZG2GdMo+w5a0K8YObm5b6mTR2
	afIoL8KIrlltAHwftMZaINL0XLR1fCAIdnu3Ve0v/Sw69feZ1HcPK3pDs14bEPDR
	G2PaHnbxti8hkBqjvST8eHyvN4AgrG0Xn6w5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B470342BC;
	Mon, 29 Jul 2013 19:32:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A004F342BA;
	Mon, 29 Jul 2013 19:32:06 +0000 (UTC)
In-Reply-To: <51F6B610.70906@xiplink.com> (Marc Branchaud's message of "Mon,
	29 Jul 2013 14:36:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DB9F4FC-F885-11E2-85F2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231320>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 13-07-29 01:52 PM, Junio C Hamano wrote:
>> Here is what I salvaged for 'maint'.  Eyeballing by others is very
>> much appreciated.
>>=20
>> -- >8 --
>> From: Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz>
>> Subject: [PATCH] many small typofixes
>> Date: Mon, 29 Jul 2013 10:18:21 +0200
>>=20
>> Signed-off-by: Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Looks good.
>
> Reviewed-by: Marc Branchaud <marcnarc@xiplink.com>
>
> 		M.

Thanks.
