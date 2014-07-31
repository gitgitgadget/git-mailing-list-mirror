From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 0/7] Rewrite `git_config()` using config-set API
Date: Thu, 31 Jul 2014 17:56:56 +0200
Message-ID: <vpqlhr9h67r.fsf@anie.imag.fr>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 17:57:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCsjJ-00087Q-Co
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 17:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbaGaP5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 11:57:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37648 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbaGaP5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 11:57:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6VFusnY030883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2014 17:56:55 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VFuu8D028048;
	Thu, 31 Jul 2014 17:56:56 +0200
In-Reply-To: <1406821662-1570-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 31 Jul 2014 08:47:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 Jul 2014 17:56:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6VFusnY030883
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407427015.7916@VHcdK3jDAsnb3jPPYSSPlQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254588>

Tanay Abhra <tanayabh@gmail.com> writes:

> [Patch v6]: Added _(....) to error messages.
> 	Diff between v6 and v4 at the bottom.

Except for the tiny style issue in PATCH 6, the series is now

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
