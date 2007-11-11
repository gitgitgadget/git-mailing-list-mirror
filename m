From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] push: mention --verbose option in documentation
Date: Sun, 11 Nov 2007 11:39:14 -0800
Message-ID: <7v8x54efml.fsf@gitster.siamese.dyndns.org>
References: <1194789708646-git-send-email-prohaska@zib.de>
	<11947897083381-git-send-email-prohaska@zib.de>
	<51B9B630-85F7-42BA-BCFF-4374A2527733@zib.de>
	<FAB11CE3-B834-45A9-9D29-A37C302A9E1D@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIeh-0008SJ-Lk
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504AbXKKTjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 14:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756502AbXKKTjX
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:39:23 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51531 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756485AbXKKTjW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:39:22 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C30BA2F2;
	Sun, 11 Nov 2007 14:39:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 690E893795;
	Sun, 11 Nov 2007 14:39:38 -0500 (EST)
In-Reply-To: <FAB11CE3-B834-45A9-9D29-A37C302A9E1D@zib.de> (Steffen Prohaska's
	message of "Sun, 11 Nov 2007 15:14:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64497>

Steffen Prohaska <prohaska@zib.de> writes:

> The Author line was already wrong in Junio's pu branch, commit
> f31447f5f06200305393ca16e2eb9485e65dcccc,  and I carried this
> over without noticing.

Yes, I know I pushed out a faulty one on 'pu' in the past.  I am
suspecting that it probably was a misuse of "git commit --author"
after _not_ applying a WS mangled patch and instead of typing,
or something like that.
