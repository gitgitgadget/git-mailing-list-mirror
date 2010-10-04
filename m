From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Mon, 04 Oct 2010 19:39:46 +0200
Message-ID: <vpqfwwlvov1.fsf@bauges.imag.fr>
References: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com>
	<1285967766.6750.2.camel@gandalf.stny.rr.com>
	<4CA9815D.3040801@drmicha.warpmail.net>
	<20101004075015.GN28679@pengutronix.de>
	<4CA98EF1.1050102@drmicha.warpmail.net>
	<20101004085050.GQ28679@pengutronix.de>
	<4CA99E43.1000204@drmicha.warpmail.net>
	<7vlj6d988o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <darren@dvhart.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 19:44:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2p5D-0006Pd-63
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 19:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162Ab0JDRoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 13:44:09 -0400
Received: from imag.imag.fr ([129.88.30.1]:47493 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687Ab0JDRoI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 13:44:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o94HdlnB020015
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Oct 2010 19:39:47 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P2p0t-00053f-60; Mon, 04 Oct 2010 19:39:47 +0200
In-Reply-To: <7vlj6d988o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 04 Oct 2010 10\:29\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 04 Oct 2010 19:39:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158072>

Junio C Hamano <gitster@pobox.com> writes:

> A "mirror"'s purpose is to, ehh, mirror a remote so that local
> people can share it as a nearby copy.

I think this is the one sentence that is missing in the description.
Even after the patch, the reader knows _what_ --mirror does, still not
really _how_ to use it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
