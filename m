From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Officially start moving to the term 'staging area'
Date: Thu, 29 Aug 2013 21:21:38 +0200
Message-ID: <vpqfvtspakd.fsf@anie.imag.fr>
References: <20130829180129.GA4880@nysa> <vpqli3kqqkp.fsf@anie.imag.fr>
	<521f998d25eb4_174378fe7481879@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 21:21:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7mz-0006Hl-SS
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 21:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916Ab3H2TVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 15:21:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57675 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756879Ab3H2TVs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 15:21:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7TJLa0o027022
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 21:21:36 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VF7mk-0003KP-W3; Thu, 29 Aug 2013 21:21:39 +0200
In-Reply-To: <521f998d25eb4_174378fe7481879@nysa.mail> (Felipe Contreras's
	message of "Thu, 29 Aug 2013 13:57:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 21:21:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TJLa0o027022
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378408901.4567@59Hu7GBg7Ud+j32qszm3Lw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233346>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> add an explanation in Documentation/gitstagingarea.txt
> or something.

There's Documentation/gitcli.txt, that will need updating anyway (at the
bottom, it talks about --cached and --index).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
