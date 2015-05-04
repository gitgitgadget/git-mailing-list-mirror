From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] standardize usage strings that were missed the first time
Date: Mon, 04 May 2015 12:23:56 -0700
Message-ID: <xmqqr3qwrvsj.fsf@gitster.dls.corp.google.com>
References: <1430536341-21847-1-git-send-email-alexhenrie24@gmail.com>
	<xmqq383dwpf4.fsf@gitster.dls.corp.google.com>
	<xmqq4mntusad.fsf@gitster.dls.corp.google.com>
	<CAMMLpeTNfe3zZgkApoXV=_Kj+bzfU1YBtyKtoPu00e8eTza_WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 21:24:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpLyG-00060t-NZ
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 21:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbbEDTYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 15:24:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751078AbbEDTX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 15:23:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B6F14DC4B;
	Mon,  4 May 2015 15:23:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RAOrhkghIKf8UY7uZKtMPbUPhJI=; b=tFJ/y1
	/FYnSSENfqI2Z/07bY0ASxDL47oFygZaJhm+is8VWUyVwhCo0ZtE5S11CerI4TIm
	0mDMUlpbPkfB9hXYNDLIb1H7OkNCZ0apTFMyirQKssoUtDEfqJ+Aha1Ei62sPajE
	8RrQNmwMpLsJ9c05WfVOo1mPQqT6Zd4ngS6nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=piTeJkAOH2UtI/RT2VDmP9C+GhoaRTLM
	mWDxc2t+cUg+9W+BzuuZp3ZJ1K5astOwu5a8ec4Cg0UavEFAc0gXVilvXRIW7kzK
	yJ7kIDqC2bR7TmQIo2xg1Mm4A0rwG4NcKLXSf0ZWaCoQ/HIQire80LEUAATTD4aG
	UvE2U6GN44Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 733014DC4A;
	Mon,  4 May 2015 15:23:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB8D54DC49;
	Mon,  4 May 2015 15:23:57 -0400 (EDT)
In-Reply-To: <CAMMLpeTNfe3zZgkApoXV=_Kj+bzfU1YBtyKtoPu00e8eTza_WA@mail.gmail.com>
	(Alex Henrie's message of "Mon, 4 May 2015 11:49:51 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C6F5724-F293-11E4-923E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268341>

Alex Henrie <alexhenrie24@gmail.com> writes:

> 2015-05-03 17:59 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
>> Here is my attempt.
>> ...
>
> Looks great, thank you.
>
> -Alex

Thanks.
