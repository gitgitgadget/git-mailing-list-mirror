From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/6] Introduce publish tracking branch
Date: Mon, 02 Sep 2013 09:25:07 +0200
Message-ID: <vpq1u57n0rw.fsf@anie.imag.fr>
References: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 09:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGOVl-0003K7-2f
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 09:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978Ab3IBHZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 03:25:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44160 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753695Ab3IBHZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 03:25:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r827P7CO009882
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Sep 2013 09:25:07 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VGOVY-0004bV-0H; Mon, 02 Sep 2013 09:25:08 +0200
In-Reply-To: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 1 Sep 2013 03:26:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 02 Sep 2013 09:25:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r827P7CO009882
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378711510.19045@5p+dMFbJCZ3PCFgn+FdhDQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233626>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Hi,
>
> As it has been discussed before, our support for triangular workflows is
> lacking, and the following patch series aims to improve that situation.

I may be stating the obvious, but isn't your series a duplicate of
remote.pushDefault, introduced in 1.8.3?

If not, how does it complement it?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
