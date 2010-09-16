From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Thu, 16 Sep 2010 07:52:24 -0700
Message-ID: <7vsk194u6v.fsf@alter.siamese.dyndns.org>
References: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de>
 <20100916125751.163d8691@jk.gs>
 <AANLkTikvW=YY2X9VR8oS2pk3fs9KFkQ_O7m=zOEN4nEk@mail.gmail.com>
 <4C91FF90.6050902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>, trast@student.ethz.ch,
	git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 16 16:52:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwFpR-00032w-Cp
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 16:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396Ab0IPOwn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 10:52:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab0IPOwm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 10:52:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9035D6DC5;
	Thu, 16 Sep 2010 10:52:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OjGfWLXmqI2v
	/0mcvI3hpu3Op9k=; b=NSYnvUn+jQP6joP0xyBCXJUhOeQVD3owH7/kC1m78MNi
	3E5paBzOWVb4ZnhK20Yzqlpw8z2IH6h/maMS4IUAhSsXCLcr0hkORuOoDjWnbOjA
	e9fY9Oc3O7KEJynk7Trmvc7u0YJQYWECMGnL5gdRXlKzVG5IguivFOtbpJ5p+FA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KeyJ50
	WsYMkZshI8OKY9l2G5x5fv1joFbjHOj0422deDwIeLn8WqC6wd0CdPblBDh6ygia
	NhuYMupQI58eY3IbNMnRzNn+htEn6MnVuaG7RhbOudR6mGCQboqlzofdLDEkc/Dv
	1cbjGQc3AtLGECoNcQoLOhlsCC4025ns0NwEE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6541AD6DC4;
	Thu, 16 Sep 2010 10:52:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4429CD6DBE; Thu, 16 Sep
 2010 10:52:26 -0400 (EDT)
In-Reply-To: <4C91FF90.6050902@web.de> (Jens Lehmann's message of "Thu\, 16
 Sep 2010 13\:29\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0992A18C-C1A2-11DF-9153-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156336>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 16.09.2010 13:09, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Thu, Sep 16, 2010 at 10:57, Jan Kr=C3=BCger <jk@jk.gs> wrote:
>>=20
>>> My main reason for not translating this one is that we have a comma=
nd
>>> called "branch" and since people need to learn what it means anyway=
,
>>> and we're certainly not going to change the command names in differ=
ent
>>> languages [...] "Markierung" doesn't come close at all to describin=
g the same
>>> concept. Conflicts markers are "Markierungen"; tags are not.
>>> The command name reasoning applies here, too.
>>=20
>> FWIW we could translate the command names if we wanted to, but wheth=
er
>> to do that or not is something we'll have to look at in due time.
>
> Are you seriously thinking about translating the "git branch" command
> into "git zweig"??? Locale-specific batch files should be real fun ..=
=2E

Perhaps "dumme zweig"?  IOW, shouldn't "git" itself be translated in su=
ch
a case?

People, please stop being ridiculous.
