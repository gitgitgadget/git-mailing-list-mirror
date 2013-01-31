From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] gitremote-helpers.txt: rename from git-remote-helpers.txt
Date: Thu, 31 Jan 2013 21:18:41 +0100
Message-ID: <vpqpq0lw1ge.fsf@grenoble-inp.fr>
References: <7vfw1ijtz2.fsf@alter.siamese.dyndns.org>
	<fc96ae61bb64ce19e856d7a1624e2130c99afd47.1359662569.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Max Horn <max@quendi.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 31 21:19:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U10bb-00006g-PI
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 21:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757038Ab3AaUTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 15:19:05 -0500
Received: from mx2.imag.fr ([129.88.30.17]:46092 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757022Ab3AaUTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 15:19:02 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r0VKIcVg019136
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 31 Jan 2013 21:18:38 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U10an-0004RI-C4; Thu, 31 Jan 2013 21:18:41 +0100
In-Reply-To: <fc96ae61bb64ce19e856d7a1624e2130c99afd47.1359662569.git.john@keeping.me.uk>
	(John Keeping's message of "Thu, 31 Jan 2013 20:08:14 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 Jan 2013 21:18:41 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0VKIcVg019136
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360268321.96696@C/2PVi87qn47gQwvpTfewA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215164>

John Keeping <john@keeping.me.uk> writes:

> Would we want to do something to avoid breaking links to the existing
> document as well?

That would be nice to add a new git-remote-helpers.txt saying "document
has moved, see linkgit:gitremote-helpers.txt[1], so that HTML links to
http://git-scm.com/docs/git-remote-helpers and friends do not get
broken, yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
