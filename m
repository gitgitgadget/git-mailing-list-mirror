From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 01/14] t0001-init.sh: use the $( ... ) construct for command substitution
Date: Mon, 28 Apr 2014 15:56:53 +0200
Message-ID: <vpqbnvlk15m.fsf@anie.imag.fr>
References: <1398689857-17014-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:57:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wem3U-0001XQ-Jo
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbaD1N5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:57:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56154 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbaD1N45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:56:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3SDuqTd029322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Apr 2014 15:56:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3SDurRH008161;
	Mon, 28 Apr 2014 15:56:53 +0200
In-Reply-To: <1398689857-17014-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Mon, 28 Apr 2014 05:57:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Apr 2014 15:56:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3SDuqTd029322
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1399298212.67257@njmAoEFEcaqY/3SHQjv4tQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247339>

Patches 1 to 14/14 are

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

(in mailer and then log -p --color-words)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
