From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 6/7] build: "make clean" should not remove configure-generated files
Date: Thu, 19 Jul 2012 09:43:22 +0200
Message-ID: <vpqpq7sdwmd.fsf@bauges.imag.fr>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
	<cover.1342649928.git.stefano.lattarini@gmail.com>
	<e763e7f466efa34f48589f8353a7316fff469145.1342649928.git.stefano.lattarini@gmail.com>
	<vpqy5mgdyro.fsf@bauges.imag.fr> <5007B780.7010500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 09:43:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlOZ-0004CS-UV
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab2GSHn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:43:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45928 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753416Ab2GSHn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 03:43:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6J7fe4e026184
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2012 09:41:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SrlON-0007rh-81; Thu, 19 Jul 2012 09:43:23 +0200
In-Reply-To: <5007B780.7010500@gmail.com> (Stefano Lattarini's message of
	"Thu, 19 Jul 2012 09:30:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 19 Jul 2012 09:41:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6J7fe4e026184
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343288500.34929@jg2TYHNZEidaPUnNPeDgTQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201717>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> Should I add "Acked-by: Matthieu Moy" then?  (Sorry if it's a dumb
> question, but I'm not sure which the preferred policy is around here).

Not necessarily needed if the patch is not otherwise controversial. The
email discussions are usually sufficient for that. I'd say you may add
it if you need to resend.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
