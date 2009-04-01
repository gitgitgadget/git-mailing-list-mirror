From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 09:42:30 +0200
Message-ID: <vpqd4bwrfa1.fsf@bauges.imag.fr>
References: <49D329A0.10769.2C57DE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 09:49:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LovCM-0008IM-2E
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 09:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759820AbZDAHrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 03:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759680AbZDAHrv
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 03:47:51 -0400
Received: from imag.imag.fr ([129.88.30.1]:61652 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759573AbZDAHrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 03:47:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n317i9jc023608
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 1 Apr 2009 09:44:09 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lov5i-0006Kj-Oo; Wed, 01 Apr 2009 09:42:30 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lov5i-00076S-MT; Wed, 01 Apr 2009 09:42:30 +0200
In-Reply-To: <49D329A0.10769.2C57DE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> (Ulrich Windl's message of "Wed\, 01 Apr 2009 08\:45\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 01 Apr 2009 09:44:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115349>

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:

> If you compiled a Linux kernel, then do an "upgrade" to the tree, it's quite 
> likely that a "make clean" after that upgrade does something different to the 
> "make clean" before the upgrade. Thus I'd "make clean" before the upgrade. (which, 
> I think, proves my point)

But why do a "make clean", at all?

-- 
Matthieu
