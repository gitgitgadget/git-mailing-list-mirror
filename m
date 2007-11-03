From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Git-windows and git-svn?
Date: Sat, 3 Nov 2007 08:16:50 +0100
Message-ID: <A35C7C2D-A829-4A16-B81B-8A6DE01FE5DB@zib.de>
References: <fgg6cd$3ep$1@ger.gmane.org> <472BABFA.6030200@obry.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Pascal Obry <pascal@obry.net>
To: Abdelrazak Younes <younes.a@free.fr>
X-From: git-owner@vger.kernel.org Sat Nov 03 08:15:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoDEQ-00047A-9q
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 08:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbXKCHPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 03:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754788AbXKCHPc
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 03:15:32 -0400
Received: from mailer.zib.de ([130.73.108.11]:40973 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230AbXKCHPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 03:15:32 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA37FTIG015834;
	Sat, 3 Nov 2007 08:15:29 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1075c.pool.einsundeins.de [77.177.7.92])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA37FStM026423
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 3 Nov 2007 08:15:28 +0100 (MET)
In-Reply-To: <472BABFA.6030200@obry.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63209>


On Nov 3, 2007, at 12:00 AM, Pascal Obry wrote:

> Abdelrazak,
>
>> I would like to try git on Windows together with git-svn, I  
>> downloaded
>>  Git-1.5.3-preview20071027.exe and tried:
>
> The best Git port on Windows is the Cygwin one. I'm using git-svn
> without trouble.

But you _MUST NOT_ use Cygwin's textmode.

	Steffen
