From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Implementation of a "textconv" filter for easy custom diff.
Date: Tue, 30 Sep 2008 17:19:49 +0200
Message-ID: <vpqk5ctfyp6.fsf@bauges.imag.fr>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
	<20080928041040.GA24214@coredump.intra.peff.net>
	<vpqd4io1tla.fsf@bauges.imag.fr>
	<20080928161106.GA30199@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 30 17:25:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkh5v-00078h-I8
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 17:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbYI3PXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 11:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbYI3PXq
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 11:23:46 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:62405 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbYI3PXp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 11:23:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m8UFJnuS010242;
	Tue, 30 Sep 2008 17:19:50 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Kkh0v-0005Ci-Lw; Tue, 30 Sep 2008 17:19:49 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Kkh0v-0003yK-Jg; Tue, 30 Sep 2008 17:19:49 +0200
In-Reply-To: <20080928161106.GA30199@coredump.intra.peff.net> (Jeff King's message of "Sun\, 28 Sep 2008 12\:11\:07 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 30 Sep 2008 17:19:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97126>

Jeff King <peff@peff.net> writes:

> On Sun, Sep 28, 2008 at 11:57:05AM +0200, Matthieu Moy wrote:
>
>> > Neat. I started on something like this quite a while ago,
>> 
>> Did you publish/send it anywhere?
>
> No, I was waiting to clean it up and test it a bit more.

Well, if you have time and you think your code is better than mine, I
can let you continue on this (and you can pick the parts you want in
mine). Otherwise, I'd be interested in seeing your draft to
incorporate the good things in my version.

Cheers,

-- 
Matthieu
