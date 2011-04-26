From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Automatically autoload bashcompinit for ZSH, when needed
Date: Tue, 26 Apr 2011 22:47:01 +0200
Message-ID: <vpqbozszqnu.fsf@bauges.imag.fr>
References: <7vtydkddto.fsf@alter.siamese.dyndns.org>
	<1303849690-20894-1-git-send-email-mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEpAG-0002Hz-Em
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 22:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757987Ab1DZUrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 16:47:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55472 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756810Ab1DZUrL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 16:47:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p3QKkxFu019056
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 26 Apr 2011 22:46:59 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QEp9x-0006ga-PU; Tue, 26 Apr 2011 22:47:01 +0200
In-Reply-To: <1303849690-20894-1-git-send-email-mstormo@gmail.com> (Marius
	Storm-Olsen's message of "Tue, 26 Apr 2011 15:28:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 26 Apr 2011 22:46:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p3QKkxFu019056
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1304455623.0422@d8WJ/uirJrtX/yHgLi1WOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172125>

Marius Storm-Olsen <marius@storm-olsen.com> writes:

> -#    2) Added the following line to your .bashrc:

> +#    2) Added the following line to your .bashrc/.zshrc:

While you're there: shouldn't this be "Add", not "Added"?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
