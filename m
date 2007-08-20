From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suprising error message from "git clone"
Date: Mon, 20 Aug 2007 14:25:40 -0700
Message-ID: <7v8x85sxt7.fsf@gitster.siamese.dyndns.org>
References: <vpqwsvqmfhw.fsf@bauges.imag.fr>
	<7vr6lyrlbb.fsf@gitster.siamese.dyndns.org>
	<vpqy7g5zz7h.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 20 23:26:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INElJ-0001Wb-Sm
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 23:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbXHTVZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbXHTVZv
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 17:25:51 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbXHTVZu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 17:25:50 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 79F561250F3;
	Mon, 20 Aug 2007 17:26:09 -0400 (EDT)
In-Reply-To: <vpqy7g5zz7h.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	20 Aug 2007 23:13:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56264>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Untested but something like this should suffice...
>
> Jest tested, it works fine.

Thanks.

>> By the way, could you possibly drop Mail-Followup-To: please?
>
> Err, what's the problem with it? I don't wish to receive duplicate,
> and I ask your mailer not to do so. I don't care too much if the
> header is not honnored, but what you have to do is just to followup
> without bothering about it.

For example, your response had this:

    Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	    git <git@vger.kernel.org>

Suppose somebody else who read your message on the git list has
something to say to _YOU_.  Maybe he is pointing out some of the
problems in _your_ thinking.  He may not mind me hearing what he
tells you, but he is primarily talking to you.

Although in practice I tend to pay attention to whatever is said
on the git mailing list, I certainly do not want _my_ address on
the To: header of such a response.  He wants to talk to _you_,
not me, and I process mails addressed "To: " me, and then only
when I have enough time to do so move on to other messages.

You either (1) stole time from me by forcing his message
addressed "To: " me, or (2) if the person who responded to your
message were kind and careful enough to "fix" the header so that
the message is addressed to you and demoting me to the Cc: list,
then you stole time from him.

With (1) you are being rude against me, and with (2) you are
being rude against whoever responds to you.

Please don't.

Filtering duplicates on the receiving end in your mailbox should
not be too much of a hassle, either.
