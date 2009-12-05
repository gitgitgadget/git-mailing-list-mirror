From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gui criticism
Date: Sat, 05 Dec 2009 12:41:16 -0800
Message-ID: <7vhbs5qhlf.fsf@alter.siamese.dyndns.org>
References: <loom.20091205T194800-496@post.gmane.org>
 <94a0d4530912051137u682a3a99ved9d19338b881b13@mail.gmail.com>
 <7v3a3prxdt.fsf@alter.siamese.dyndns.org>
 <94a0d4530912051225y2d193a1fqfb38ebcce95719c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ram Rachum <cool-rr@cool-rr.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 21:41:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH1Re-0007xK-8b
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 21:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757735AbZLEUlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 15:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757691AbZLEUlU
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 15:41:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757735AbZLEUlT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 15:41:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5838A857B2;
	Sat,  5 Dec 2009 15:41:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vd89nYHUlRFKYtEmzLTtRseFGX0=; b=M4k1gg
	X8Of5oYbdLiGeRQbobsI8xgsknftvgY3Mk0RF8Ndlx5Z2HIQ2jOaeWBcZteN3ryw
	iCM0Zi7fvlSrzqm0YUPKUxBUkOOvGxFG0ILmcXWcS3+UCUonO/ufMGtWSc/XohyX
	BKERUU5lNZbtyD8fecGtHyFwTZWdMAcBsuDKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TreaDOnyLil/A+HFGfpqyiirMBrZsgFg
	+xmLsxh5PHxnfvUi/P5+MTlY6Rk3sSti5+7jUU1DHXTInBAsEc3bFrdQY7OXk8UZ
	pTOngWCM8f1xTUpkMy1W2YmbIMQeJvuR5fsyGOr/YmbDr6wngkvwfPOgCx4V8cZ1
	yr0IKaMCrjo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23EC1857B1;
	Sat,  5 Dec 2009 15:41:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E783857AF; Sat,  5 Dec
 2009 15:41:18 -0500 (EST)
In-Reply-To: <94a0d4530912051225y2d193a1fqfb38ebcce95719c3@mail.gmail.com>
 (Felipe Contreras's message of "Sat\, 5 Dec 2009 22\:25\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C55A460-E1DE-11DE-ADAB-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134621>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Also, the main action to do in this system should be "vote", that's
> the action that should be fast.

Actually I do not think you would want that, especially as a moderator (I
am assuming that you would be self-appointing to be one).  What will you
do to help a "broad, vague, and infeasible idea" forward when it gets many
votes?

That is why I prefer a system that requires substance when voicing an
opinion ("Yes I like the solution because in addition to the original
problem description it will also help this use case"), and it also is the
reason I tend to ignore e-mails that only say "+1" on this list.

In other words, this is not a democracy, and you do not necessarily want a
democracy that is prone to populism.
