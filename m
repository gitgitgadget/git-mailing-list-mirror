From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v11 0/4] git config cache & special querying api utilizing the cache
Date: Sat, 19 Jul 2014 11:50:56 +0200
Message-ID: <vpqd2d1vfr3.fsf@anie.imag.fr>
References: <1405748778-3755-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 11:51:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8RIP-0001ci-5E
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 11:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbaGSJvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 05:51:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48947 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755875AbaGSJvG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 05:51:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6J9otAq011487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jul 2014 11:50:55 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6J9ou6J000752;
	Sat, 19 Jul 2014 11:50:56 +0200
In-Reply-To: <1405748778-3755-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Fri, 18 Jul 2014 22:46:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 19 Jul 2014 11:50:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6J9otAq011487
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406368258.80766@pqKQYDNyMAePUGcro8zG7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253874>

Tanay Abhra <tanayabh@gmail.com> writes:

> Hi,
>
> [PATCH V11]: very minor fixes. check [13] for discussion.

Perfect, all my remarks have been taken into account, and I guess
Junio's too.

The whole series is now
Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
