From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Suppress spurious linefeeds in git-add--interactive
Date: Thu, 22 Nov 2007 02:38:01 -0800
Message-ID: <7vzlx65zw6.fsf@gitster.siamese.dyndns.org>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com>
	<1195689773-28601-1-git-send-email-win@wincent.com>
	<1195689773-28601-2-git-send-email-win@wincent.com>
	<20071122085919.GB7153@sigill.intra.peff.net>
	<B649FFCA-C85F-4BB4-884A-525676ABCA9B@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 11:38:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9S0-0002f5-8o
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbXKVKiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 05:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbXKVKiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:38:09 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33042 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbXKVKiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 05:38:08 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0A7162F9;
	Thu, 22 Nov 2007 05:38:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E10096657;
	Thu, 22 Nov 2007 05:38:24 -0500 (EST)
In-Reply-To: <B649FFCA-C85F-4BB4-884A-525676ABCA9B@wincent.com> (Wincent
	Colaiuta's message of "Thu, 22 Nov 2007 11:18:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65775>

Wincent Colaiuta <win@wincent.com> writes:

> No, I agree with you; it does read nicer. I'm not a real Perl  
> programmer, so everything I do I have to do it with a copy of  
> "Programming Perl" next to me to find out how to do things. It's handy  
> to have advice from people more familiar with the idioms. Will  
> incorporate something like this into the series:

I took the liberty of rewriting them and will push out on pu
shortly hopefully before I go to bed.
