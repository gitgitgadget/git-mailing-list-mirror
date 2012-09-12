From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Handle "git show" output correctly.
Date: Wed, 12 Sep 2012 17:41:41 +0200
Message-ID: <vpqligfz1sa.fsf@bauges.imag.fr>
References: <1347463571-16831-1-git-send-email-pjones@redhat.com>
	<1347463833-16952-1-git-send-email-pjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Peter Jones <pjones@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 17:41:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBp4g-0002e0-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 17:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760202Ab2ILPls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 11:41:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52464 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755650Ab2ILPlr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 11:41:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8CFbE00001477
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 12 Sep 2012 17:37:14 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TBp4Q-0006jH-7P; Wed, 12 Sep 2012 17:41:42 +0200
In-Reply-To: <1347463833-16952-1-git-send-email-pjones@redhat.com> (Peter
	Jones's message of "Wed, 12 Sep 2012 11:30:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Sep 2012 17:37:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8CFbE00001477
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1348069035.56309@KIzpSAk65LFhHjgzxbRi2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205303>

Peter Jones <pjones@redhat.com> writes:

> (this version with fixed tabs)

This will end up being the commit message. If you add text here, then
the maintainer will have to manually fix it when applying (or reject
your patch). Please, be nice with him and put your comments below the
--- :

> Signed-off-by: Peter Jones <pjones@redhat.com>
> ---

(ie. here)

>  git-am.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
