From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 07/25] contrib: remove 'git-jump'
Date: Fri, 09 May 2014 10:37:32 -0700
Message-ID: <xmqqppjmzwdf.fsf@gitster.dls.corp.google.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
	<1399597116-1851-8-git-send-email-felipe.contreras@gmail.com>
	<20140509020350.GD9787@sigill.intra.peff.net>
	<536c399454062_741a161d31099@nysa.notmuch>
	<20140509152005.GB18197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 09 19:37:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wiojx-0002mO-2x
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbaEIRhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 13:37:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59067 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbaEIRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 13:37:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B901415808;
	Fri,  9 May 2014 13:37:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HbtQj6C5P7Vo77AF/WpV82bxMTI=; b=p8fiHp
	X2+hewcVIVfGUBr7Vqon6BMsUWxklgMBzUS3hdNyCo7THs9WqiWCNszBwpXiShoe
	QZh7K2a0Jo2YtNKj+Bs0UN+fQ/xbtP9cAMyF6XrvnOwPNG0RlZHCgJMOraN9OHhP
	jw6iRczN9afKLwh1naAxgCkVDNbQ6ple21tM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LxcZwzu0v80QSqDrWmC8Qc8CeEwh85FZ
	iEJQbfauBUFx2BDS9Ved/xiYXFw473g2QUsToQacxp6mLHw6xyLIdBKCFSUkE0N3
	Wga4GUe6xzzzG9MAphqeO1pXwaezvX7/DBfAmSQAAJHYe/OM6dVfLTIXiJ0KCG1O
	Hvk5ZpgAg2A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB64315807;
	Fri,  9 May 2014 13:37:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8117515802;
	Fri,  9 May 2014 13:37:34 -0400 (EDT)
In-Reply-To: <20140509152005.GB18197@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 9 May 2014 11:20:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9AEFDE0C-D7A0-11E3-BD77-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248595>

Jeff King <peff@peff.net> writes:

> And speaking of wasted time, I do not plan on responding further to you
> in this thread. I am telling you ahead of time that this is the case,
> because elsewhere[1] I saw you complaining that Junio did not respond to
> your emails, which you seemed to think was because he cannot admit that
> he was wrong. So I want to say up front that I am going to avoid
> interacting with you further because it generally seems fruitless,
> consumes a large amount of time, and causes me a great deal of stress.
>
> -Peff
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/248441

Heh, well said.  I'll follow suit, then.
