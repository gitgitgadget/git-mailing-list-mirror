From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] configure.ac: try -lpthread in $LIBS instead of $CFLAGS
Date: Sun, 08 Nov 2015 17:00:00 +0100
Message-ID: <vpqy4e8cwhr.fsf@anie.imag.fr>
References: <201511081528.tA8FSgdc003895@tezro.nonet>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Rainer M. Canavan" <git@canavan.de>
X-From: git-owner@vger.kernel.org Sun Nov 08 17:00:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvSOY-0006vx-Fv
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 17:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbbKHQAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 11:00:12 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43138 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbbKHQAL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2015 11:00:11 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id tA8FxxHe022785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 8 Nov 2015 16:59:59 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tA8G00hs021204;
	Sun, 8 Nov 2015 17:00:00 +0100
In-Reply-To: <201511081528.tA8FSgdc003895@tezro.nonet> (Rainer M. Canavan's
	message of "Sun, 8 Nov 2015 16:28:42 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 08 Nov 2015 16:59:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tA8FxxHe022785
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1447603201.67398@KrwOJEEsYkuJOrYMmQwNUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281039>

"Rainer M. Canavan" <git@canavan.de> writes:

>  configure.ac | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Looks all right to me. Thanks for you contribution and for your
patience!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
