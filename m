From: Richard Bubel <bubel@cs.chalmers.se>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Wed, 15 Oct 2008 17:01:44 +0200
Message-ID: <DE453BEE-6749-4892-BFAA-3B37CFAADD3E@cs.chalmers.se>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net> <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl> <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Pieter de Bie" <pdebie@ai.rug.nl>, "Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>
To: Lars Hoss <lars@woeye.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:12:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq82h-0001vr-Rh
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 17:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbYJOPKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 11:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbYJOPKz
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 11:10:55 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:40438 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYJOPKy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 11:10:54 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Oct 2008 11:10:54 EDT
Received: from dhcp-250-28.nomad.chalmers.se (dhcp-250-28.nomad.chalmers.se [129.16.250.28])
	(Authenticated sender: bubel)
	by mail.chalmers.se (Postfix) with ESMTP id 2D58B83F6;
	Wed, 15 Oct 2008 17:01:45 +0200 (CEST)
In-Reply-To: <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
X-Priority: 3 (Normal)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98279>

Hi,

On Oct 15, 2008, at 16:51 , Lars Hoss wrote:

>> Works for me on Leopard
>> [...]
>> Vienna:a pieter$ git --version
>> git version 1.6.0.2.415.gf9137
>
> My git version "1.6.0.2" says:
>
> # On branch master
> [...]
> git --version
> git version 1.6.0.2
>
> Git was build from macports.


works for me too on OS X 10.5.5 with git 1.6.0.2 from MacPorts. As it  
deviates from the default, it might be worth mentioning that the  
filesystem in use here is the case-sensitive version of HFS+.

Best Regards,
   Richard
