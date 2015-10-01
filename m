From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] status: don't say 'HEAD detached at HEAD'
Date: Thu, 01 Oct 2015 18:53:24 +0200
Message-ID: <vpq8u7mbke3.fsf@grenoble-inp.fr>
References: <1443366822-1753-1-git-send-email-Matthieu.Moy@imag.fr>
	<1443366822-1753-2-git-send-email-Matthieu.Moy@imag.fr>
	<560D154F.9000809@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 01 18:53:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhh6w-0002r0-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 18:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbbJAQxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 12:53:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41237 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbbJAQxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 12:53:33 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t91GrMPR016669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 1 Oct 2015 18:53:22 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t91GrOSX004775;
	Thu, 1 Oct 2015 18:53:24 +0200
In-Reply-To: <560D154F.9000809@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 1 Oct 2015 13:13:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 01 Oct 2015 18:53:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t91GrMPR016669
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444323203.93581@pHiPZtKCKPYvdY7q4faaeA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278894>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio will also want your s-o-by, though ;)

Argh, sorry. I normally have an alias to do this for me, but my
git-send-email is temporarily broken and I forget to sign-off
explicitly.

I see that Junio already queued the patches in pu.

In case it matters, both patches are

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

and I can resend if needed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
