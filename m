From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for 2.3.0
Date: Mon, 02 Feb 2015 12:06:17 -0800
Message-ID: <xmqqfvaot6x2.fsf@gitster.dls.corp.google.com>
References: <CANYiYbF4F4z60HsC=Eb2vjuU9DihncHf1OeLTTi_VMkg0_mE9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Alex Henrie <alexhenrie24@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:06:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YINGP-0006Zk-BB
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 21:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbbBBUGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 15:06:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754474AbbBBUGY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 15:06:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3874F35044;
	Mon,  2 Feb 2015 15:06:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=PLxsev
	RnukzON+CyQbNEdieoHU5+H+tbCV/EY8q1O0CSVaJseylo7h/qznIfcmsFceKuN2
	Nj54XXyNUErxBzU4HHF0sJVs6q854LzUUv6g03OYK98PiZJaqJ0AJAQM5FsVDKSS
	ELJiW3Dc7yKZtvUFOoEOp/Xlj0qhRi2uNBVic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ec2DtUCajv4IYw88FQinkJtisaV8o7GA
	dtYV5EAgmKltYgcdjlbLN8e89ANHQR44xBS+xkllEZCm83gMCvvFisvT5bll0MWY
	zFGy9kAKj+bqpn4vNbdSD2dDif4Yxv0vjUP5E0e4j76fJO9Zx/CLJ2W26ov3UrLe
	G0QclwEy+mM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 265D23503B;
	Mon,  2 Feb 2015 15:06:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9828F3503A;
	Mon,  2 Feb 2015 15:06:18 -0500 (EST)
In-Reply-To: <CANYiYbF4F4z60HsC=Eb2vjuU9DihncHf1OeLTTi_VMkg0_mE9g@mail.gmail.com>
	(Jiang Xin's message of "Sun, 1 Feb 2015 11:14:43 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F33B949E-AB16-11E4-AA75-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263284>

Thanks.
