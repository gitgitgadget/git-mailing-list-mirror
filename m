From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Documentation: add setup instructions for Travis CI
Date: Mon, 02 May 2016 10:48:34 +0200
Message-ID: <vpqwpncq1zx.fsf@anie.imag.fr>
References: <E3568F7F-1C20-4B9F-BDF1-94A9DA08D5F7@gmail.com>
	<1462176732-5163-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon May 02 10:48:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax9X4-0006RA-2H
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 10:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbcEBIsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 04:48:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49419 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbcEBIsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 04:48:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u428mX9K012225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 2 May 2016 10:48:34 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u428mYeM024129;
	Mon, 2 May 2016 10:48:34 +0200
In-Reply-To: <1462176732-5163-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Mon, 2 May 2016 10:12:12
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 02 May 2016 10:48:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u428mX9K012225
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1462783714.83731@Dl0QmTegQcWJZxQYtoJ8xA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293233>

larsxschneider@gmail.com writes:

> +on open source projects), you can use their Travis CI integration to
> +test your changes on Linux, Mac, and (hopefully soon) Windows.  See

Nit: I'd write Linux, Mac (and hopefully soon Windows). Doesn't deserve
a reroll IHMO.

Other than that, the patch looks good to me.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
