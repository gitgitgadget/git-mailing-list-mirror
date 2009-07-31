From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Feature Request: Capability to save and load the workspace
Date: Fri, 31 Jul 2009 14:08:41 +0200
Message-ID: <vpqr5vxukae.fsf@bauges.imag.fr>
References: <4A72AF1C.1020500@ubicom.com>
	<40aa078e0907310209p458cf912r1eb4329a409cefa7@mail.gmail.com>
	<CB2DD11991B27C4F99935E6229450D3204837B8F@STORK.scenix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Erik Faye-Lund" <kusmabite@googlemail.com>, <git@vger.kernel.org>
To: "Yakup Akbay" <yakbay@ubicom.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 14:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWquu-0000MP-PY
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 14:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbZGaMIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 08:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbZGaMIt
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 08:08:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50496 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbZGaMIs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 08:08:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n6VC8Aqj031128
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 31 Jul 2009 14:08:10 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MWquf-0001UL-N0; Fri, 31 Jul 2009 14:08:41 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MWquf-0006EF-Li; Fri, 31 Jul 2009 14:08:41 +0200
In-Reply-To: <CB2DD11991B27C4F99935E6229450D3204837B8F@STORK.scenix.com> (Yakup Akbay's message of "Fri\, 31 Jul 2009 02\:16\:58 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 31 Jul 2009 14:08:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n6VC8Aqj031128
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1249646891.32144@kPYWsb/nmIMktJoFe2XlJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124549>

"Yakup Akbay" <yakbay@ubicom.com> writes:

> AFAIK, git-stash does not save untracked and ignored files. What I need
> is to save them, too.

See
http://thread.gmane.org/gmane.comp.version-control.git/109103
for a discussion around the same idea.

-- 
Matthieu
