From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git push bug?
Date: Thu, 18 Oct 2007 18:13:11 +0200
Message-ID: <CDE0C821-4CD9-46D4-8FC7-FC51B0D9C3D6@zib.de>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se> <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de> <1192723269.9433.21.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: joakim.tjernlund@transmode.se
X-From: git-owner@vger.kernel.org Thu Oct 18 18:11:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiXyX-0001so-3C
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 18:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509AbXJRQLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 12:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757498AbXJRQLq
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 12:11:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:57176 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757182AbXJRQLq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 12:11:46 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9IGBgHc000505;
	Thu, 18 Oct 2007 18:11:42 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9IGBgR8021130
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 18 Oct 2007 18:11:42 +0200 (MEST)
In-Reply-To: <1192723269.9433.21.camel@gentoo-jocke.transmode.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61541>


On Oct 18, 2007, at 6:01 PM, Joakim Tjernlund wrote:

> Seems like it is a bit too easy to make mistakes here. Why can I  
> delete
> a branch with :linus but not create one with linus:linus?
> Also confusing that git lets me create refs/head/linus when git branch
> cannot find it.

I absolutely agree. But I'm not sure if those who use git since the
ancient days do agree too.
	
	Steffen
