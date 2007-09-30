From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: suggestion for git stash
Date: Sun, 30 Sep 2007 22:28:16 +0200
Message-ID: <vpqk5q77va7.fsf@bauges.imag.fr>
References: <200709302050.41273.bruno@clisp.org>
	<7vfy0vhqkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruno Haible <bruno@clisp.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 22:28:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic5P7-0007H0-Gr
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 22:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbXI3U2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 16:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbXI3U2d
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 16:28:33 -0400
Received: from imag.imag.fr ([129.88.30.1]:56710 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbXI3U2d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 16:28:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l8UKSGaO000338
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 30 Sep 2007 22:28:17 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ic5Oi-0004UK-Q4; Sun, 30 Sep 2007 22:28:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Ic5Oi-0001mF-Ne; Sun, 30 Sep 2007 22:28:16 +0200
In-Reply-To: <7vfy0vhqkl.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 30 Sep 2007 12\:59\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 30 Sep 2007 22:28:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59560>

Junio C Hamano <gitster@pobox.com> writes:

> Isn't "stash apply --index" what you talk about?

It doesn't seem to be documented in Documentation/git-stash.txt, but
seems to be the answer.

-- 
Matthieu
