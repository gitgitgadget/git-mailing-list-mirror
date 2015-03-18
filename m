From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 1/4] git-credential-store: support multiple credential files
Date: Wed, 18 Mar 2015 17:17:46 +0100
Message-ID: <vpqh9tifff9.fsf@anie.imag.fr>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 17:18:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYGfb-0002lC-O4
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 17:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710AbbCRQSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 12:18:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52464 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754737AbbCRQSG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 12:18:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2IGHjff001547
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Mar 2015 17:17:45 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2IGHkU0016207;
	Wed, 18 Mar 2015 17:17:46 +0100
In-Reply-To: <1426662276-8728-1-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Wed, 18 Mar 2015 15:04:33 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 18 Mar 2015 17:17:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2IGHjff001547
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1427300267.5883@anYKH+Dw3zsQmXA2Zcb+gg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265739>

Paul Tan <pyokagan@gmail.com> writes:

> +	/* Write credential to the filename specified by fns->items[0], thus
> +	 * creating it */

Just to show I'm following: misformatted multi-line comment.

Other than that, good job!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
