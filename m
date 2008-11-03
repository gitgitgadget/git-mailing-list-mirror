From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 3/3] git send-email: add --annotate option
Date: Mon, 03 Nov 2008 13:18:35 +0100
Message-ID: <vpqk5blknok.fsf@bauges.imag.fr>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
	<1225450632-7230-2-git-send-email-madcoder@debian.org>
	<1225450632-7230-3-git-send-email-madcoder@debian.org>
	<1225450632-7230-4-git-send-email-madcoder@debian.org>
	<7vskqa3atg.fsf@gitster.siamese.dyndns.org>
	<20081102095152.GG4066@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 13:23:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwySO-00069i-M9
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 13:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbYKCMVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 07:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754852AbYKCMVn
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 07:21:43 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:46115 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754178AbYKCMVm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 07:21:42 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id mA3CJQHj000070;
	Mon, 3 Nov 2008 13:19:26 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KwyOC-0002vo-0g; Mon, 03 Nov 2008 13:18:36 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KwyOB-0004cV-US; Mon, 03 Nov 2008 13:18:35 +0100
In-Reply-To: <20081102095152.GG4066@artemis> (Pierre Habouzit's message of "Sun\, 02 Nov 2008 10\:51\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 03 Nov 2008 13:19:26 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99936>

Pierre Habouzit <madcoder@debian.org> writes:

> I don't know for others, but with those series, git-send-email is
> _REALLY_ what I would have wanted it to be from day 1.

Same for me. I didn't really understand why git was asking me to run
two separate commands to send a patch. Having git-send-email do
everything and ask me only the required is really the way I expected
it to be.

(probably not a coincidence that at least bzr and darcs have a "send"
command that does just this)

-- 
Matthieu
