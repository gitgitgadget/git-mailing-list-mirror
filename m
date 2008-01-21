From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to UTF8
Date: Mon, 21 Jan 2008 03:29:14 -0800
Message-ID: <7v3asrzab9.fsf@gitster.siamese.dyndns.org>
References: <fn1nl6$ek5$1@ger.gmane.org>
	<alpine.LSU.1.00.0801211121440.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 12:30:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGuqh-0006Ku-Sw
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 12:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758141AbYAUL30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 06:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758033AbYAUL30
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 06:29:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36319 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757891AbYAUL30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 06:29:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 57C7542C8;
	Mon, 21 Jan 2008 06:29:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D3BF142C7;
	Mon, 21 Jan 2008 06:29:20 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801211121440.5731@racer.site> (Johannes
	Schindelin's message of "Mon, 21 Jan 2008 11:24:20 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71265>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> - it contains questions in the commit message? WTF?  Should it not be 
>   marked as PATCH/RFC, possibly without a signoff to make sure that you 
>   want to discuss it first?

Sign-off is about "this is kosher, from licensing point of view"
and nothing else.  Please do not suggest otherwise.

I do not mind discussions during the feature freeze as long as
it stays at "feeler" level.
