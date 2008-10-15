From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Wed, 15 Oct 2008 16:59:39 +0200
Message-ID: <A0A3837E-7F85-4172-A8BA-969BFD46CF48@ai.rug.nl>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net> <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl> <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>
To: Lars Hoss <lars@woeye.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:01:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq7sD-0006Lg-SO
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 17:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbYJOO7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 10:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbYJOO7u
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 10:59:50 -0400
Received: from frim.nl ([87.230.85.232]:40521 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752584AbYJOO7t (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 10:59:49 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1Kq7qk-0003zu-Dz; Wed, 15 Oct 2008 16:59:46 +0200
In-Reply-To: <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
X-Priority: 3 (Normal)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98278>


On 15 okt 2008, at 16:51, Lars Hoss wrote:
> My git version "1.6.0.2" says:
>
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #	lib/
> git --version
> git version 1.6.0.2


I just tested 1.6.0.2, and had no problems. Perhaps macports is doing  
something odd?
