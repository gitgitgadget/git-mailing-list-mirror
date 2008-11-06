From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (MINGW) Resend] Windows: Make OpenSSH properly detect
 tty detachment.
Date: Thu, 06 Nov 2008 18:21:20 +0100
Message-ID: <49132790.9080105@viscovery.net>
References: <200811022011.13970.angavrilov@gmail.com> <49129E47.4080209@viscovery.net> <7vvdv0iyl2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 18:22:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky8Z4-0001M0-Mw
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 18:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbYKFRVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 12:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbYKFRVY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 12:21:24 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:2359 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbYKFRVY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 12:21:24 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ky8Xo-0006Uk-TJ; Thu, 06 Nov 2008 18:21:21 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A51E24E4; Thu,  6 Nov 2008 18:21:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vvdv0iyl2.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100250>

Junio C Hamano schrieb:
> Do people build and test MinGW port out of my 'next'?  If so, I'll queue
> this on its own topic branch and have it go through the usual "cook then
> graduate" cycle.  Otherwise, I'll apply this directly on top of 'master'.

My own build is on top of your 'master', and I've cooked this patch to
death there already, so I don't think it needs another cycle. ;)

-- Hannes
