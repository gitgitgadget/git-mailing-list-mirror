From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/2] config.c: mark error and warnings strings for translation
Date: Thu, 31 Jul 2014 15:50:52 +0200
Message-ID: <vpq8un9ljr7.fsf@anie.imag.fr>
References: <1406814126-10457-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 15:51:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCql9-0003CM-02
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 15:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbaGaNvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 09:51:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34531 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbaGaNu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 09:50:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6VDooJ1030065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2014 15:50:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VDoqYm026725;
	Thu, 31 Jul 2014 15:50:52 +0200
In-Reply-To: <1406814126-10457-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 31 Jul 2014 06:42:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 Jul 2014 15:50:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6VDooJ1030065
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407419455.03271@xT99YTKesWH/mE9vIAnZpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254576>

Tanay Abhra <tanayabh@gmail.com> writes:

> From: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> v2: error messages now start with a small letter.

Thanks. Ack on both patches.

Is there any reason not to include these two patches in the larger
series? (There's a semantic dependency on the changed error message and
test)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
