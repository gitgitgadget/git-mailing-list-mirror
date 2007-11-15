From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improved and extended t5404
Date: Wed, 14 Nov 2007 21:55:40 -0800
Message-ID: <7vhcjo8337.fsf@gitster.siamese.dyndns.org>
References: <20071112213823.GB2918@steel.home>
	<20071112213938.GC2918@steel.home>
	<20071113075240.GA21799@sigill.intra.peff.net>
	<20071113194731.GC3268@steel.home> <20071113194909.GD3268@steel.home>
	<20071113230234.GI3268@steel.home>
	<7vmythr8xf.fsf@gitster.siamese.dyndns.org>
	<20071114071929.GA2942@steel.home>
	<20071115041801.GA9794@sigill.intra.peff.net>
	<20071115043513.GA10193@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 06:56:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsXhv-0000lO-31
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 06:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbXKOFzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 00:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbXKOFzt
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 00:55:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52328 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbXKOFzs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 00:55:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4B7942EF;
	Thu, 15 Nov 2007 00:56:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CD3B994B1E;
	Thu, 15 Nov 2007 00:56:03 -0500 (EST)
In-Reply-To: <20071115043513.GA10193@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 14 Nov 2007 23:35:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65062>

Jeff King <peff@peff.net> writes:

> ... So you can only ever _know_ success,
> and with failure, you simply guess (and presumably retry).

Good thinking.  I agree.
