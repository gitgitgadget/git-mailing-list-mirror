From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] Git.pm: Add interface for git credential command.
Date: Thu, 07 Feb 2013 08:22:49 +0100
Message-ID: <vpqpq0cvb92.fsf@grenoble-inp.fr>
References: <cover.1360183427.git.mina86@mina86.com>
	<cover.1360183427.git.mina86@mina86.com>
	<f4b5413b0a55474346daa7b0866c7a4fed55778d.1360183427.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 08:24:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3LqR-0005jN-U5
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 08:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab3BGHYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 02:24:08 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37814 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752379Ab3BGHYG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 02:24:06 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r177MnEC003790
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Feb 2013 08:22:49 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U3Lon-0005em-TL; Thu, 07 Feb 2013 08:22:49 +0100
In-Reply-To: <f4b5413b0a55474346daa7b0866c7a4fed55778d.1360183427.git.mina86@mina86.com>
	(Michal Nazarewicz's message of "Wed, 6 Feb 2013 21:47:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Feb 2013 08:22:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r177MnEC003790
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360826570.36123@P7EKeRpceJsFgkIeRtW9Qw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215676>

Michal Nazarewicz <mpn@google.com> writes:

> Subject: [PATCH 3/4] Git.pm: Add interface for git credential command.

Ah, just a nitpick: usually we write the message without capital after
":" and without the final ".".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
