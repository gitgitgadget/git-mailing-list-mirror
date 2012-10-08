From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: In search of a version control system
Date: Mon, 08 Oct 2012 20:30:00 +0200
Message-ID: <vpqa9vwstp3.fsf@grenoble-inp.fr>
References: <1349719581.76671.YahooMailNeo@web122505.mail.ne1.yahoo.com>
	<CALkWK0kCbLxPMbxh=CLAE8UkkNFNqDa1QbtdM_-Q+Qr3SRh46Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Maurice Francois <francoismaurice2001@yahoo.ca>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 20:30:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLI5u-0001bZ-SK
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 20:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab2JHSaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 14:30:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33546 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582Ab2JHSaL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 14:30:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q98INPDN025142
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 8 Oct 2012 20:23:25 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TLI5Y-0001gy-KH; Mon, 08 Oct 2012 20:30:00 +0200
In-Reply-To: <CALkWK0kCbLxPMbxh=CLAE8UkkNFNqDa1QbtdM_-Q+Qr3SRh46Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 8 Oct 2012 23:54:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 08 Oct 2012 20:23:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q98INPDN025142
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1350325409.23907@aVkUJ5xvP98Je6McWmVWlw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207258>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> So, is it possible to lock a file while someone work on it ?
>
> No, and I honestly think it's a bad idea.

If you work on non-mergeable files (e.g. *.doc files. There are merge
tools for MS Word and LibreOffice, but my experience with them was not
really pleasant), then file locking is indeed not such a bad idea.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
