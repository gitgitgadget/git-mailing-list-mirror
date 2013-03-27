From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git status takes 30 seconds on Windows 7. Why?
Date: Wed, 27 Mar 2013 18:17:52 +0100
Message-ID: <vpqr4j0rccf.fsf@grenoble-inp.fr>
References: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jim Kinsman <jakinsman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:18:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtzS-0006kt-Q2
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab3C0RRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:17:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55085 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab3C0RRy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:17:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r2RHHoJi020557
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Mar 2013 18:17:50 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UKtyy-0001uZ-GO; Wed, 27 Mar 2013 18:17:52 +0100
In-Reply-To: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
	(Jim Kinsman's message of "Wed, 27 Mar 2013 11:39:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 27 Mar 2013 18:17:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2RHHoJi020557
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365009470.55849@1sSJiKvo5m0WRX3aCtdxiA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219284>

Jim Kinsman <jakinsman@gmail.com> writes:

> git status takes 30 seconds on Windows 7.

Any anti-virus installed? They can interfer badly with disk-intensive
tasks ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
