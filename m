From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] for the SoC15 micro project, Make "git -C '' cmd" not to barf.
Date: Fri, 06 Mar 2015 12:54:56 +0100
Message-ID: <vpqzj7qcpdb.fsf@anie.imag.fr>
References: <CAMS+ib3dDP6PmHvLJsSs-6XCy233gxjU6=+_7id8yuk9xTnCJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Prudhvee Narasimha Sadha <prudhvi.sada@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 12:55:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTqqP-0000jM-Sd
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 12:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbbCFLzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 06:55:01 -0500
Received: from mx1.imag.fr ([129.88.30.5]:52749 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525AbbCFLzA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 06:55:00 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t26BstTR018064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Mar 2015 12:54:55 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t26BsuxF021373;
	Fri, 6 Mar 2015 12:54:56 +0100
In-Reply-To: <CAMS+ib3dDP6PmHvLJsSs-6XCy233gxjU6=+_7id8yuk9xTnCJQ@mail.gmail.com>
	(Prudhvee Narasimha Sadha's message of "Fri, 6 Mar 2015 07:16:36
	+0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 06 Mar 2015 12:54:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t26BstTR018064
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426247696.16336@jscJ1XuACNBk3Ph8QKfilQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264917>

Prudhvee Narasimha Sadha <prudhvi.sada@gmail.com> writes:

> Hi,
>     here is my patch for the micro project, Please review the code.

Please, read Documentation/SubmittingPatches.

Also, read the comments on the other submission for the same problem on
the list, they also apply to your version.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
