From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please review this pull request for maint branch with update of
 de.po
Date: Fri, 11 May 2012 15:28:11 -0700
Message-ID: <7vr4uqjqtg.fsf@alter.siamese.dyndns.org>
References: <CANYiYbFf73hVen2sg1viNrXxt-g+tP=bF_ryBF8JYp0ZAL0b6A@mail.gmail.com>
 <CANYiYbFiwvy8Lw+XQTehbc3k2FukrvhCvR6urfAR_3xVqXxNZA@mail.gmail.com>
 <7vtxzr1kbd.fsf@alter.siamese.dyndns.org> <87ipg75drv.fsf@thomas.inf.ethz.ch>
 <7vipg2le0u.fsf@alter.siamese.dyndns.org>
 <CAN0XMOKi7PMLC0fSpT3n1+fYL_Uop1XGiTi_BJCRuxPRRknd7Q@mail.gmail.com>
 <7vehqqld4w.fsf@alter.siamese.dyndns.org>
 <CAN0XMOJLrGcB3=jy09b57FPc=ZoRxmo1Gx09vOLoxPexEe5fiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Sat May 12 00:28:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSyJy-0000tr-3m
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 00:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933306Ab2EKW2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 18:28:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57039 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933296Ab2EKW2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 18:28:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50E248D5E;
	Fri, 11 May 2012 18:28:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lpH7x/t00m2zTxFfMN/ez4RTPUQ=; b=BzF1H+
	adTZy7B47ptGCuJYp5UIUYYDiRvSg2I0hcWNDhea1f7BEEyuVSmYEQ/Hw3RPp5rN
	RYp5QOJgQdZN/LxZl9rsAv2OqntiD0VBT0E6XsWIEFuoLJkaIxxVLJUEu4SU0MjF
	eL1nCYhuYSafCUdMUDepj7V7DND5dr71rVyig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HaeMHhQSPr/hQDOgkm7DTJTW/AiAJjsG
	BdWGhFSe942VZNmaxDoorMSbwdWTWPta+5ZaX5fySXCUGCekLlcMSYI8/xUUkI14
	xnnZBarKCUulVH8JTAKE5i6bd5MyASA+XZrzLbDt1cJwoPB67v7YeiZAhDXnrfPH
	jDYz2eL2NBc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 470338D5C;
	Fri, 11 May 2012 18:28:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C51B08D5A; Fri, 11 May 2012
 18:28:14 -0400 (EDT)
In-Reply-To: <CAN0XMOJLrGcB3=jy09b57FPc=ZoRxmo1Gx09vOLoxPexEe5fiQ@mail.gmail.com> (Ralf
 Thielow's message of "Fri, 11 May 2012 21:50:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9971AC70-9BB8-11E1-B447-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197701>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

> On Fri, May 11, 2012 at 9:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ralf Thielow <ralf.thielow@googlemail.com> writes:
>>
>>> What about a README file like "/po" has?
>>
>> Sorry, but I cannot tell what you want to know about it.
>
> This was just an idea to do it in the same way.
> What I want to say is that there is a README file in the po folder which
> telling people that if they want to change something here, they have
> to go through
> the git.l10n repo to get changes into the git-core repo.
> That's presumably the same situation here, isn't it?

Hmph.  I thought we had something that was meant for contributors in
Documentation/SubmittingPatches, but apparently we don't.
