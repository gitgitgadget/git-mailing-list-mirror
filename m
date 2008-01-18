From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 03:40:16 -0800
Message-ID: <7vsl0ve50f.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
	<47908CAF.90101@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 12:41:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFpan-0005bB-9c
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 12:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491AbYARLkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 06:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbYARLkb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 06:40:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbYARLka (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 06:40:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 416C273F1;
	Fri, 18 Jan 2008 06:40:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B6D3F73F0;
	Fri, 18 Jan 2008 06:40:22 -0500 (EST)
In-Reply-To: <47908CAF.90101@viscovery.net> (Johannes Sixt's message of "Fri,
	18 Jan 2008 12:25:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71003>

Johannes Sixt <j.sixt@viscovery.net> writes:

> BTW, how would you like to have a 40+ patch series presented that
> implements the port to MinGW? Should I send to the ML despite its volume?

My gut feeling is that you did your usual great job separating
them into logical chunks and it will be a pleasure to review on
the usual channel, just like the trickle you did earlier.

> The current state of the series is available here:
> http://repo.or.cz/w/git/mingw/j6t.git?a=shortlog;h=upstream

Let me take a look sometime (but I cannot even say when right
now).  I might change my mind about the above.
