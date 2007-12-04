From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Set OLD_ICONV on Cygwin.
Date: Tue, 04 Dec 2007 13:59:33 -0800
Message-ID: <7vaboq3yuy.fsf@gitster.siamese.dyndns.org>
References: <21977191.137171196775591804.JavaMail.www@wwinf1621>
	<4755597B.9050709@op5.se> <7v63ze5osn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pascal Obry <pascal.obry@wanadoo.fr>,
	Pascal Obry <pascal@obry.net>,
	Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Dec 04 23:00:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzfoF-0000b9-H8
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 23:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbXLDV7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 16:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbXLDV7p
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 16:59:45 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39689 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbXLDV7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 16:59:44 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3C1CE2FA;
	Tue,  4 Dec 2007 17:00:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 98C9A9CE70;
	Tue,  4 Dec 2007 16:59:57 -0500 (EST)
In-Reply-To: <7v63ze5osn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 04 Dec 2007 09:54:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67087>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Ericsson <ae@op5.se> writes:
>
>> Nice. If my suspicions are correct and he missed your patch the first time
>> around, you should probably resend it though.
>
> I still have it in my mailbox.
>
> I saw the patch but saw nobody else said about the patch being helpful
> to his installation, nor more importantly, "Good, this won't hurt for me
> who run a different vintage of Cygwin", and I was waiting for such
> confirmations.
>
> Then nobody responded, so I forgot.
>
> That was what happened the first time Pascal's patch was posted.

I think the patch is fine; I just checked with my copy of Cygwin that I
haven't fired for some time (it was a pain waiting for it to update to
the latest set of git sources).

I am at work and will be busy for the rest of the afternoon, so won't be
applying it until this evening, though.
