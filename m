From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] status: show commit sha1 in "You are currently cherry-picking" message
Date: Fri, 11 Oct 2013 18:03:12 +0200
Message-ID: <vpqtxgng5hb.fsf@anie.imag.fr>
References: <1381507117-11519-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 11 18:03:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUfBY-000290-Ca
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 18:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758127Ab3JKQDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 12:03:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49382 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457Ab3JKQDX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 12:03:23 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r9BG3A7m011267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Oct 2013 18:03:10 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id r9BG3Cxw029671
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 11 Oct 2013 18:03:12 +0200
In-Reply-To: <1381507117-11519-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Fri, 11 Oct 2013 17:58:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 11 Oct 2013 18:03:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r9BG3A7m011267
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1382112195.57285@1Fveim1im6APOHjLNXW0IQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235911>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Especially helpful when cherry-picking multiple commits.

I think this would deserve to be in the commit message (but don't
consider that blocking).

Other than that, looks good to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
