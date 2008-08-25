From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Suggestion: "man git clone"
Date: Mon, 25 Aug 2008 14:38:58 +0200
Message-ID: <vpqk5e52rrx.fsf@bauges.imag.fr>
References: <48ACB29C.7000606@zytor.com> <g8m6d1$7nf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Mon Aug 25 14:42:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXbOO-0003HW-Ko
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 14:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbYHYMkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 08:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbYHYMkt
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 08:40:49 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:64091 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566AbYHYMkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 08:40:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m7PCd4ej000537;
	Mon, 25 Aug 2008 14:39:08 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KXbLW-0008WL-J3; Mon, 25 Aug 2008 14:38:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KXbLW-0001re-GS; Mon, 25 Aug 2008 14:38:58 +0200
In-Reply-To: <g8m6d1$7nf$1@ger.gmane.org> (Michael J. Gruber's message of "Fri\, 22 Aug 2008 13\:02\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 25 Aug 2008 14:39:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93616>

Michael J Gruber <michaeljgruber+gmane@fastmail.fm> writes:

> I've heard about some other SCMs which have only "scm help bla", so this
> suggestion would be in-line with common usage. [Not that git would have
> to learn from other SCM's ;) ]

OTOH, I like the fact that the manpages be browsable with man. As an
Emacs user, I often do M-x man RET git-whatever RET, other people can
enjoy their favorite man reader.

If git starts hiding that "man" stuff to the user, (s)he may just fail
to notice that it is possible.

-- 
Matthieu
