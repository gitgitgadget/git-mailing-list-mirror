From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9 0/8] Rewrite `git_config()` using config-set API
Date: Thu, 07 Aug 2014 14:15:38 +0200
Message-ID: <vpqmwbgijh1.fsf@anie.imag.fr>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 14:15:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFMbr-0000S0-Vx
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 14:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235AbaHGMPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 08:15:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43503 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754303AbaHGMPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 08:15:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s77CFbPa021531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Aug 2014 14:15:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s77CFcPW001441;
	Thu, 7 Aug 2014 14:15:38 +0200
In-Reply-To: <1407412759-13833-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 7 Aug 2014 04:59:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Aug 2014 14:15:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s77CFbPa021531
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408018537.80415@8zJxpUx9Nic7kKfFx4jagQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254958>

Tanay Abhra <tanayabh@gmail.com> writes:

> [Patch v9]: Changed the grep statements in patch 7/8 and 8/8.

Good. I think it adresses all previous comments.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
