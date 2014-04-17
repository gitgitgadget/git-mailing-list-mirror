From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 001/14] howto-index.sh: use the $( ... ) construct for command substitution
Date: Thu, 17 Apr 2014 11:00:54 +0200
Message-ID: <vpqsipc1gah.fsf@anie.imag.fr>
References: <1397669398-25410-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 11:01:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaiBw-0003LW-DQ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 11:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbaDQJBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 05:01:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:32832 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbaDQJA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 05:00:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3H90rsS014023
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Apr 2014 11:00:53 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3H90sU8032071;
	Thu, 17 Apr 2014 11:00:54 +0200
In-Reply-To: <1397669398-25410-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Wed, 16 Apr 2014 10:29:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 17 Apr 2014 11:00:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3H90rsS014023
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1398330054.02566@BBde4fLBOtdgWjrNFZ/Rwg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246414>

Elia Pinto <gitter.spiros@gmail.com> writes:

> The Git CodingGuidelines prefer the $(...) construct for command
> substitution instead of using the backquotes `...`.

For patches 1 to 14:

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

(reviewed the patches in my mailer, and the "diff --color-words=." after
applying in addition)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
