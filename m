From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: compat/mkdtemp.c: patch for gitmkdtemp() compatibility implementation
Date: Thu, 25 Feb 2010 10:31:19 +0100
Message-ID: <vpqy6ih4q6w.fsf@bauges.imag.fr>
References: <4B863C58.7010105@flexerasoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Filippo Negroni <fnegroni@flexerasoftware.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 10:31:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nka4G-0008RK-B4
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 10:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab0BYJba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 04:31:30 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47322 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538Ab0BYJb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 04:31:28 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o1P9SpKa023105
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 25 Feb 2010 10:28:51 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Nka3z-0000Tp-AL; Thu, 25 Feb 2010 10:31:19 +0100
In-Reply-To: <4B863C58.7010105@flexerasoftware.com> (Filippo Negroni's message of "Thu\, 25 Feb 2010 09\:01\:12 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Feb 2010 10:28:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o1P9SpKa023105
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1267694932.45669@iU4O9uOPu6r6M2JJK9mq1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141039>

Thanks for your contribution to git. However ...

Filippo Negroni <fnegroni@flexerasoftware.com> writes:

> Please let me know if you need the patch in any other way.

Please, read

http://repo.or.cz/w/git.git?a=blob;f=Documentation/SubmittingPatches;hb=HEAD

especially about inlining the patch and Signed-off-by, to make it easy
and legally possible for our maintainer to apply your patch.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
