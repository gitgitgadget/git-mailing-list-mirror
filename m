From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document conding style
Date: Wed, 27 Feb 2008 09:43:04 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802270941040.22527@racer.site>
References: <12041000101604-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Wed Feb 27 10:44:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUIpj-0006FS-NT
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 10:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYB0Jni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 04:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbYB0Jni
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 04:43:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:43203 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751451AbYB0Jnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 04:43:37 -0500
Received: (qmail invoked by alias); 27 Feb 2008 09:43:35 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp014) with SMTP; 27 Feb 2008 10:43:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19sCsxLkshshjfR26P/mQZAPUBBsFtGy6mG08RkRZ
	7ubLUomLC6RkTa
X-X-Sender: gene099@racer.site
In-Reply-To: <12041000101604-git-send-email-mkoegler@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75218>

Hi,

[it is "coding", not "conding", and technically, it is already documented]

Alternatively, we could repeat these lines from the existing 
CodingGuidelines 3 times:

> As for more concrete guidelines, just imitate the existing code
> (this is a good guideline, no matter which project you are
> contributing to).

And maybe hint at "git diff --check" _before_ committing?

Ciao,
Dscho
