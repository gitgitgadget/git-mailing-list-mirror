From: Thomas Koch <thomas@koch.ro>
Subject: Re: encrypted repositories? with git-torrent?
Date: Sat, 18 Jul 2009 21:09:30 +0200
Message-ID: <200907182109.31275.thomas@koch.ro>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de> <alpine.LFD.2.01.0907171337320.13838@localhost.localdomain> <alpine.LFD.2.01.0907171341040.13838@localhost.localdomain>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 18 21:09:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSFIC-00072E-6i
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 21:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbZGRTJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 15:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbZGRTJp
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 15:09:45 -0400
Received: from koch.ro ([93.90.184.107]:49484 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751371AbZGRTJp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2009 15:09:45 -0400
Received: from 4-186.0-85.cust.bluewin.ch ([85.0.186.4] helo=jona.localnet)
	by ve825703057.providerbox.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1MSFHt-0001SP-Co; Sat, 18 Jul 2009 21:09:37 +0200
User-Agent: KMail/1.11.4 (Linux/2.6.29-1-amd64; KDE/4.2.4; x86_64; ; )
In-Reply-To: <alpine.LFD.2.01.0907171341040.13838@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123533>

Wouldn't this be a use case for git-torrent?
http://code.google.com/p/gittorrent/
http://repo.or.cz/w/VCS-Git-Torrent.git

As I understand it, all data would be stored decentraliced and the (optional?) 
central server only saves, who has which objects.

(Just hearing a podcast on bittorrent while reading GIT mailinglist :-)

Thomas Koch, http://www.koch.ro
