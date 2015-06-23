From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 4/5] bisect: add the terms old/new
Date: Tue, 23 Jun 2015 22:26:18 +0200
Message-ID: <vpqy4jakw7p.fsf@anie.imag.fr>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435064084-5554-5-git-send-email-Matthieu.Moy@imag.fr>
	<303519671.732577.1435087672353.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, git@vger.kernel.org,
	antoine delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:26:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Um7-0006cr-II
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbbFWU02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:26:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49373 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932538AbbFWU00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 16:26:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5NKQGcB006014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Jun 2015 22:26:16 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5NKQIAE011581;
	Tue, 23 Jun 2015 22:26:18 +0200
In-Reply-To: <303519671.732577.1435087672353.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Tue, 23 Jun 2015 21:27:52 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Jun 2015 22:26:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5NKQGcB006014
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435695979.6785@nvm+jv558DW/Jf+gK3bFYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272497>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> Sounds like you went all out with this patch.

Ah, the first line was in the original patch, and the second is added by
send-email -s ... Both me and myself agree that one of them can be
removed indeed ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
