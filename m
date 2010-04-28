From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Git and cvsimport
Date: Wed, 28 Apr 2010 11:19:36 +0200
Message-ID: <m21ve0vsrb.fsf@igel.home>
References: <i2l717f7a3e1004260727wd87900a5tcfb61a3142d0ba@mail.gmail.com>
	<4BD69450.8040608@drmicha.warpmail.net>
	<l2w717f7a3e1004270341lea6cfe2aqdf8d2b490b1ec067@mail.gmail.com>
	<r2xd2d39d861004270458v2e1cb73by78f53d71103b47e6@mail.gmail.com>
	<k2r717f7a3e1004272227g256c42fei6951180db855ad9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arntsen <tor@spacetec.no>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Marin Atanasov Nikolov <dnaeon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 11:19:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O73Qp-00058f-TT
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 11:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab0D1JTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 05:19:41 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57246 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0D1JTk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 05:19:40 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id CAFAB1C15954;
	Wed, 28 Apr 2010 11:19:38 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 3FAD4903FE;
	Wed, 28 Apr 2010 11:19:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id Grbz4+MdSzZe; Wed, 28 Apr 2010 11:19:37 +0200 (CEST)
Received: from igel.home (ppp-88-217-116-118.dynamic.mnet-online.de [88.217.116.118])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 28 Apr 2010 11:19:37 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id EFBD6CA297; Wed, 28 Apr 2010 11:19:36 +0200 (CEST)
X-Yow: I'LL get it!!  It's probably a FEW of my ITALIAN GIRL-FRIENDS!!
In-Reply-To: <k2r717f7a3e1004272227g256c42fei6951180db855ad9f@mail.gmail.com>
	(Marin Atanasov Nikolov's message of "Wed, 28 Apr 2010 08:27:28
	+0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145981>

Marin Atanasov Nikolov <dnaeon@gmail.com> writes:

>  1. git-cvsimport the whole CVS repository.

That's all you need, IIUC.  There are other tools like parsecvs and
cvs2git that may produce better results than git-cvsimport, though.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
