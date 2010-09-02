From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Sep 2010, #01; Wed, 1)
Date: Thu, 02 Sep 2010 10:52:07 +0200
Message-ID: <vpq4oe8le88.fsf@bauges.imag.fr>
References: <7vaao15jk2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 10:58:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or5ca-00052X-AB
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 10:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab0IBI6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 04:58:02 -0400
Received: from imag.imag.fr ([129.88.30.1]:41380 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623Ab0IBI6B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 04:58:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o828q7AI005572
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Sep 2010 10:52:07 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Or5Wh-0003NY-Hs; Thu, 02 Sep 2010 10:52:07 +0200
In-Reply-To: <7vaao15jk2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 01 Sep 2010 12\:51\:25 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 02 Sep 2010 10:52:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155115>

Junio C Hamano <gitster@pobox.com> writes:

> * po/etc-gitattributes (2010-09-01) 1 commit
>  - Add global and system-wide gitattributes

/me is happy, pu contains the last version of the patch, with the test
and without the bugs ;-).

> I think the idea is sound.  For a patch that touches fairly core part of
> the system, it came a bit late in the cycle, though.

I'm fine with delaying this after the release.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
