From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Do not let lstree output recursively when a directory whose name is a prefix of the others is given in the path list.
Date: Thu, 09 Sep 2010 23:22:52 +0200
Message-ID: <vpqtylyvcgj.fsf@bauges.imag.fr>
References: <1284010826-81989-1-git-send-email-davi.reis@gmail.com>
	<vpqzkvr5u73.fsf@bauges.imag.fr>
	<AANLkTikZ11-3QhOxoW096cdA4LryuZQiegg=GLMO0BJB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Davi Reis <davi.reis@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 23:23:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtoaI-0003tZ-Fw
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 23:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab0IIVW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 17:22:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60723 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755886Ab0IIVW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 17:22:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o89LIrsX027216
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 9 Sep 2010 23:18:53 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Otoa5-0000L6-4S; Thu, 09 Sep 2010 23:22:53 +0200
In-Reply-To: <AANLkTikZ11-3QhOxoW096cdA4LryuZQiegg=GLMO0BJB@mail.gmail.com> (Davi Reis's message of "Thu\, 9 Sep 2010 11\:26\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 09 Sep 2010 23:18:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o89LIrsX027216
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1284671937.54451@2xvQcKa9miyZhmK6NfNSLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155903>

Davi Reis <davi.reis@gmail.com> writes:

> I added the test and used git-sendemail again, but I guess it ended up
> in a different thread.

--in-reply-to is your friend ;-).

> Is this good enough or is there some formal path that I should take?

I'll comment in the other thread.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
