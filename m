From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: emacs and git...
Date: Thu, 22 Mar 2007 16:50:11 +0100
Message-ID: <vpqr6rhwa4s.fsf@olympe.imag.fr>
References: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 16:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUPYg-0003ZN-Q9
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 16:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933471AbXCVPub (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 11:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933460AbXCVPub
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 11:50:31 -0400
Received: from imag.imag.fr ([129.88.30.1]:40238 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933471AbXCVPua (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 11:50:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l2MFoB7C008854
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 22 Mar 2007 16:50:11 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HUPYJ-0001DH-Ib
	for git@vger.kernel.org; Thu, 22 Mar 2007 16:50:11 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HUPYJ-00008o-G2
	for git@vger.kernel.org; Thu, 22 Mar 2007 16:50:11 +0100
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com> (Francis Moreau's message of "Thu\, 22 Mar 2007 15\:53\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 22 Mar 2007 16:50:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42859>

"Francis Moreau" <francis.moro@gmail.com> writes:

> Hi,
>
> I guess it's a dumb...
>
> I know that some of you work within emacs. I tried to use git iniside
> a emacs shell (M-x shell) and had a weid behaviour:

DVC has an embryo of a git mode (development not active at the
moment).

  http://download.gna.org/dvc/

There's also a git.el which I didn't try yet.

-- 
Matthieu
