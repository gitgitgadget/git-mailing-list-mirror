From: David Mansfield <david@cobite.com>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 18:25:08 -0400
Message-ID: <4293A9C4.3000408@cobite.com>
References: <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <20050524161745.GA9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org> <20050524202846.GC25606@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241345280.2307@ppc970.osdl.org> <20050524215238.GG25606@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241502160.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 00:28:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dahrb-00084Y-7J
	for gcvg-git@gmane.org; Wed, 25 May 2005 00:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVEXW2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 18:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVEXW04
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 18:26:56 -0400
Received: from iris.cobite.com ([208.222.83.2]:62854 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S262150AbVEXWZL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 18:25:11 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 3204598502; Tue, 24 May 2005 18:25:04 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16174-03; Tue, 24 May 2005 18:25:04 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id E0C5B987BB; Tue, 24 May 2005 18:25:03 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 7CF3D98502; Tue, 24 May 2005 18:25:02 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241502160.2307@ppc970.osdl.org>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>Linus Saith,
> 
> Anyway, what worries me more is that cvsps might have re-ordered other 
> changesets than just the first two. It probably doesn't _matter_, but 
> still...
> 

I think I have an idea to prevent this incorrect ordering of patchsets. 
  We'll see in the morning how it works out.

David
