From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv3 1/2] git-rebase.txt: "--onto" option updated
Date: Fri, 08 Jun 2012 17:00:10 +0200
Message-ID: <vpqaa0drgqt.fsf@bauges.imag.fr>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 17:00:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd0fr-0002Bz-Ix
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 17:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761073Ab2FHPAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 11:00:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38472 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761059Ab2FHPAR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 11:00:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q58EpR9J003637
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 16:51:27 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sd0fb-0007uy-LQ; Fri, 08 Jun 2012 17:00:11 +0200
In-Reply-To: <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Lucien Kong's message of "Fri, 8 Jun 2012 16:53:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Jun 2012 16:51:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q58EpR9J003637
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339771889.7638@paDHpScDgNvFnNcu93ezuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199501>

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

> +	<newbase>. <newbase is the starting point at which to create

Missing > after <newbase.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
