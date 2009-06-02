From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git checkout -b -t
Date: Tue, 02 Jun 2009 17:05:55 +0200
Message-ID: <vpqbpp67k18.fsf@bauges.imag.fr>
References: <43d8ce650906020749r36a0cceao20dc54d1446a6ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:11:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBVeD-0006My-S8
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 17:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbZFBPLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 11:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbZFBPLP
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 11:11:15 -0400
Received: from imag.imag.fr ([129.88.30.1]:46352 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811AbZFBPLP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 11:11:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n52F60Y2010098
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Jun 2009 17:06:00 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MBVYp-0004vV-FV; Tue, 02 Jun 2009 17:05:55 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MBVYp-0001V9-9D; Tue, 02 Jun 2009 17:05:55 +0200
In-Reply-To: <43d8ce650906020749r36a0cceao20dc54d1446a6ea@mail.gmail.com> (John Tapsell's message of "Tue\, 2 Jun 2009 15\:49\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 02 Jun 2009 17:06:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120516>

John Tapsell <johnflux@gmail.com> writes:

> $ git branch -D -t
>
> Doesn't work.

Not really answering the question, but "git branch -D -- -t" should work.

-- 
Matthieu
