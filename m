From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Mon, 04 Jun 2012 22:06:34 +0200
Message-ID: <vpqpq9en8ol.fsf@bauges.imag.fr>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
	<1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
	<7vsjecvxmc.fsf@alter.siamese.dyndns.org>
	<vpq1ulvuxd9.fsf@bauges.imag.fr>
	<20120604115630.GC27676@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 22:06:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbdY9-0006X8-M3
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 22:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757344Ab2FDUGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 16:06:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52228 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760Ab2FDUGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 16:06:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q54Jw26K021553
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 21:58:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SbdXv-0000XZ-Js; Mon, 04 Jun 2012 22:06:35 +0200
In-Reply-To: <20120604115630.GC27676@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 4 Jun 2012 07:56:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Jun 2012 21:58:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54Jw26K021553
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339444683.2042@p1T6yzv9zTq/fbYYqSkSYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199176>

Jeff King <peff@peff.net> writes:

> We only build html documentation from technical/, not manpages. So they
> could just all be switched to link: (the point of linkgit is to format a
> manpage reference from either html or a manpage).

OTOH, using linkgit: makes it easier to cut-and-paste from technical/ to
man pages (which may be sensible for plumbing commands), so I think it's
OK to keep linkgit:.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
