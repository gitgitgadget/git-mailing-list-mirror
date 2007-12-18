From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document diff.external and mergetool.<tool>.path
Date: Mon, 17 Dec 2007 16:52:01 -0800
Message-ID: <7vy7bs3jv2.fsf@gitster.siamese.dyndns.org>
References: <E6DFE65BB5ADFE44BE13CCC976124447D5BB8D@fue-email2.ad.mc.com>
	<Pine.LNX.4.64.0712171220540.9446@racer.site>
	<7vtzmg5072.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712180047300.9446@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Schuberth, Sebastian" <sschuberth@visageimaging.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 01:52:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4QhM-0005wo-22
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 01:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbXLRAwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 19:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbXLRAwQ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 19:52:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbXLRAwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 19:52:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 063A14450;
	Mon, 17 Dec 2007 19:52:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AF5E444F;
	Mon, 17 Dec 2007 19:52:03 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712180047300.9446@racer.site> (Johannes
	Schindelin's message of "Tue, 18 Dec 2007 00:47:47 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68678>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 17 Dec 2007, Junio C Hamano wrote:
>
>> Thanks.  Applied.
>
> Dumb question: with, or without, the diff.external patch?

Swapped the order to first make diff.external work and then document.
