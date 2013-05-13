From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 00/10] interactive git clean
Date: Mon, 13 May 2013 08:55:22 +0200
Message-ID: <vpqhai7fjxh.fsf@grenoble-inp.fr>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<CAPig+cR6aa+xODi=8DoiBpqQZM1eBHkGBvGzMGB2PSiT3osMEw@mail.gmail.com>
	<7vwqr9fo9b.fsf@alter.siamese.dyndns.org>
	<vpq8v3khzty.fsf@grenoble-inp.fr>
	<CANYiYbFo+_048_1r1vmPzuRjibnrCuG19pCQg-UtXsBE2Cpyug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 08:59:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbmjT-0001s8-MQ
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 08:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab3EMGzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 02:55:42 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58188 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969Ab3EMGzl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 02:55:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4D6tMaD010340
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 13 May 2013 08:55:22 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UbmfK-0007L9-Vt; Mon, 13 May 2013 08:55:23 +0200
In-Reply-To: <CANYiYbFo+_048_1r1vmPzuRjibnrCuG19pCQg-UtXsBE2Cpyug@mail.gmail.com>
	(Jiang Xin's message of "Mon, 13 May 2013 10:34:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 13 May 2013 08:55:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4D6tMaD010340
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369032926.63319@QXoDLrnHvFbncd8l6zLNUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224098>

Jiang Xin <worldhello.net@gmail.com> writes:

> My initial intention for flags toggle is for git newbies, who are not clear
> about how to use -x/-d/-X/-ff options. I feel it may have values for these
> people.

It may have value for some of them, but throwing too many options in a
menu is usually counter-productive for a newbie. I never heard anyone
say "Git is super newbie-friendly because it has so many commands", but
quite often the opposite.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
