From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] color: set color.ui to auto by default
Date: Thu, 16 May 2013 15:25:20 +0200
Message-ID: <vpqfvxn12gv.fsf@grenoble-inp.fr>
References: <1368709468-18610-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 15:25:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcyBd-0001Vo-4U
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 15:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab3EPNZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 09:25:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56175 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921Ab3EPNZc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 09:25:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4GDPJQn009526
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 16 May 2013 15:25:19 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UcyBM-0007VE-UN; Thu, 16 May 2013 15:25:20 +0200
In-Reply-To: <1368709468-18610-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 16 May 2013 18:34:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 16 May 2013 15:25:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4GDPJQn009526
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369315521.60341@n37s+e7pdBtEcnMglTyraA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224564>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> This is a good default.  Users who don't want color can look for "color"
> in the git-config(1), and turn it off.

Err, you're comming a bit late ;-). See my patch, posted yesterday, for
the same topic.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
