From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] trailer: support multiline title
Date: Mon, 31 Aug 2015 10:38:38 +0200
Message-ID: <vpqtwrfg8dt.fsf@anie.imag.fr>
References: <1440962080-24804-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 10:38:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWKc4-0000wl-6I
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 10:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbbHaIio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 04:38:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45724 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbbHaIin (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 04:38:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7V8cbJh016657
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 31 Aug 2015 10:38:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7V8ccSG010267;
	Mon, 31 Aug 2015 10:38:38 +0200
In-Reply-To: <1440962080-24804-1-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Sun, 30 Aug 2015 21:14:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 31 Aug 2015 10:38:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7V8cbJh016657
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441615117.62039@/1zc8d3nEw8E6L6tW+39xQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276856>

Christian Couder <christian.couder@gmail.com> writes:

> That's why instead of ignoring only the first line, it is better to
> ignore the first paragraph.
> ---

Lacks sign-off again.

This replaces PATCH 2/2 in your previous series, but requires PATCH 1/2,
right? If so that would be simpler to resend both patches IMHO.

The patch works for me, thanks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
