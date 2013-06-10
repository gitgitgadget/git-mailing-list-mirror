From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: v3 [PATCH 1/2] status: introduce status.short to enable --short by default
Date: Mon, 10 Jun 2013 17:20:04 +0200
Message-ID: <vpqehcaf0wr.fsf@anie.imag.fr>
References: <1370877184-19409-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 17:20:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um3tJ-0002vo-OX
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 17:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab3FJPUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 11:20:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:32976 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab3FJPUK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 11:20:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5AFK2v7011292
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 17:20:02 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Um3t6-0003V7-9N; Mon, 10 Jun 2013 17:20:04 +0200
References: 
In-Reply-To: <1370877184-19409-1-git-send-email-y> (y.'s message of "Mon, 10
	Jun 2013 17:13:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 17:20:03 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227302>

y@ensimag.imag.fr writes:

> To: y@ensimag.imag.fr

Common mistake, but you're not supposed to answer "y" when you're
prompted for an email ;-).

set sendemail.from to avoid this.

> +test_expect_success '"Setup of environment of test"' '

Same problem as v2.

> +test_expect_success '"Back to environment of test by default"' '
> +	git config status.showUntrackedFiles yes

Same.

Probably something went wrong during your rebase.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
