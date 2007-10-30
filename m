From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] push: change push to fail if short refname does not exist
Date: Tue, 30 Oct 2007 02:22:37 -0700
Message-ID: <7v7il5lzxe.fsf@gitster.siamese.dyndns.org>
References: <1193593581312-git-send-email-prohaska@zib.de>
	<11935935812741-git-send-email-prohaska@zib.de>
	<7vwst5m2eq.fsf@gitster.siamese.dyndns.org>
	<AD10F15D-0F77-42BB-86CA-6404063C784B@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 10:23:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImnJa-0004jS-31
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 10:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365AbXJ3JWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 05:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757360AbXJ3JWp
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 05:22:45 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:36432 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757354AbXJ3JWo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 05:22:44 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 257BA2F2;
	Tue, 30 Oct 2007 05:23:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A7E628F3AF;
	Tue, 30 Oct 2007 05:23:02 -0400 (EDT)
In-Reply-To: <AD10F15D-0F77-42BB-86CA-6404063C784B@zib.de> (Steffen Prohaska's
	message of "Tue, 30 Oct 2007 09:56:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Steffen Prohaska <prohaska@zib.de> writes:

> On Oct 30, 2007, at 9:29 AM, Junio C Hamano wrote:
> ...
>> Will drop 1/10 and 2/10 for now.
>
> Then they'll be dropped and I'll rely on the the --dry-run flag.
>
> Or someone else needs to step in and support my point.

Yup, you exactly got what I meant by "for now".  I reserve the
right to be convinced and converted later ;-).
