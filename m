From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: encrypted repositories? with git-torrent?
Date: Mon, 20 Jul 2009 14:13:31 +0200
Message-ID: <op.uxc78tdp1e62zd@balu.cs.uni-paderborn.de>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
 <alpine.LFD.2.01.0907171337320.13838@localhost.localdomain>
 <alpine.LFD.2.01.0907171341040.13838@localhost.localdomain>
 <200907182109.31275.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "John Tapsell" <johnflux@gmail.com>, git@vger.kernel.org
To: thomas@koch.ro, "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 14:13:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSrkT-0000Uk-SO
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 14:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbZGTMNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 08:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbZGTMNf
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 08:13:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:33747 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750780AbZGTMNe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 08:13:34 -0400
Received: (qmail invoked by alias); 20 Jul 2009 12:13:33 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp044) with SMTP; 20 Jul 2009 14:13:33 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX19IouVR8KtIDtx/QDNVzl/7j6tQhzn/Tl6fevBhnb
	eQMtLK3We8l0aj
Received: from localhost ([127.0.0.1] helo=balu.cs.uni-paderborn.de)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KN2XYK-0004GO-5O; Mon, 20 Jul 2009 14:13:32 +0200
In-Reply-To: <200907182109.31275.thomas@koch.ro>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123597>

Am 18.07.2009, 21:09 Uhr, schrieb Thomas Koch <thomas@koch.ro>:

> Wouldn't this be a use case for git-torrent?
> http://code.google.com/p/gittorrent/
> http://repo.or.cz/w/VCS-Git-Torrent.git
>
> As I understand it, all data would be stored decentraliced and the  
> (optional?) central server only saves, who has which objects.

I wonder about latency and accessibility here if clients are disconnected.  
Seems this is more for transferring repositories to large numbers of  
customers as sort of content distribution network for high load, rather  
than low connectivity - and the latter is my prime concern and also a  
detail of my scenario.

-- 
Matthias Andree
