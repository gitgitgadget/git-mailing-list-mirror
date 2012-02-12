From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git documentation at kernel.org
Date: Sun, 12 Feb 2012 23:04:23 +0100
Message-ID: <vpqehtz909k.fsf@bauges.imag.fr>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
	<20120208213410.GA5768@ecki> <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
	<20120210200401.GB5504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 12 23:04:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwhXL-0003H8-Lj
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 23:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab2BLWEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 17:04:42 -0500
Received: from mx1.imag.fr ([129.88.30.5]:38799 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438Ab2BLWEl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 17:04:41 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q1CM1T6K000363
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 12 Feb 2012 23:01:29 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RwhWy-0004Dh-BO; Sun, 12 Feb 2012 23:04:24 +0100
In-Reply-To: <20120210200401.GB5504@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 10 Feb 2012 15:04:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 12 Feb 2012 23:01:30 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1CM1T6K000363
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1329688890.83229@oxpmXgKZI+M+7VyUTEhwVw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190591>

Jeff King <peff@peff.net> writes:

> If there is interest in this, we would be happy to host the
> documentation. Let me know if that is the case, and we can give it a
> much better URL than schacon.github.com. However, I tend to think that
> since the project is hosted[1] at kernel.org, the official documentation
> site should be there as well.

kernel.org is probably the most "official" place for developers, but for
Git users, http://git-scm.com/ is most likely the best entry point. If
it were not for historical reasons, I think http://git-scm.com/docs/ or
so would be the most natural URL to host official docs.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
