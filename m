From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git.txt: update description of the configuration mechanism
Date: Thu, 14 Feb 2013 18:36:25 +0100
Message-ID: <vpqy5eq94rq.fsf@grenoble-inp.fr>
References: <1360856214-934-1-git-send-email-Matthieu.Moy@imag.fr>
	<511D0D88.6010302@drmicha.warpmail.net>
	<vpqzjz6ampm.fsf@grenoble-inp.fr>
	<7v4nhe3joq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:37:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U62k0-0007Ce-OO
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 18:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885Ab3BNRgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 12:36:37 -0500
Received: from mx1.imag.fr ([129.88.30.5]:40307 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759909Ab3BNRgg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 12:36:36 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1EHaOlN002916
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Feb 2013 18:36:24 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U62jS-0002Ck-0F; Thu, 14 Feb 2013 18:36:26 +0100
In-Reply-To: <7v4nhe3joq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 14 Feb 2013 09:10:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 14 Feb 2013 18:36:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1EHaOlN002916
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361468185.4436@hjxzzYORmr2pIU0pC+m0bA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216326>

Junio C Hamano <gitster@pobox.com> writes:

> But the exact location of per-user and per-repository configuration
> files does not matter in this context and is best left to the
> git-config documentation.

I'm OK with your version.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
