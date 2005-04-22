From: "John Stoffel" <john@stoffel.org>
Subject: Re: Pasky problem with 'git init URL'
Date: Fri, 22 Apr 2005 08:44:45 -0400
Message-ID: <17000.61885.545203.936684@smtp.charter.net>
References: <1114100518.17551.31.camel@nosferatu.lan>
	<20050421202928.GH7443@pasky.ji.cz>
	<17000.6154.748117.967898@smtp.charter.net>
	<20050421212648.GM7443@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: John Stoffel <john@stoffel.org>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 14:40:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOxSC-0006OW-J7
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 14:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVDVMot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 08:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVDVMot
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 08:44:49 -0400
Received: from mxsf03.cluster1.charter.net ([209.225.28.203]:30651 "EHLO
	mxsf03.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262035AbVDVMor (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 08:44:47 -0400
Received: from mxip16.cluster1.charter.net (mxip16a.cluster1.charter.net [209.225.28.146])
	by mxsf03.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id j3MCikaV003175
	for <git@vger.kernel.org>; Fri, 22 Apr 2005 08:44:46 -0400
Received: from 24-107-225-41.dhcp.oxfr.ma.charter.com (HELO jfsnew) (24.107.225.41)
  by mxip16.cluster1.charter.net with ESMTP; 22 Apr 2005 08:44:46 -0400
X-Ironport-AV: i="3.92,123,1112587200"; 
   d="scan'208"; a="1052783786:sNHT13034456"
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050421212648.GM7443@pasky.ji.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Petr> Dear diary, on Thu, Apr 21, 2005 at 11:15:54PM CEST, I got a letter
Petr> where John Stoffel <john@stoffel.org> told me that...
>> >>>>> "Petr" == Petr Baudis <pasky@ucw.cz> writes:
>> 
Petr> Perhaps it would be useful to have some "command classes" (with at least
Petr> cg-*-(add|ls|rm)), like:
>> 
Petr> cg-branch-ls
Petr> cg-remote-rm
Petr> cg-tag-add
>> 
>> Does a standard like:
>> 
>> git <objecttype> <command> <args> [<obj> ...]

Petr> Isn't this basically what I was proposing? (Modulo the UI
Petr> changes related to git-pasky -> Cogito.)

I'm not quite upto speed on git, I was away on vacation when the list
started up and didn't catch it until just recently... 

And it is close to what you were proposing, but instead of dashes (-)
between the command and the object, I'm proposing just a space.
Actually, I'm proposing that we decide on a grammar and it's syntax
and to try and make it orthagonal and consistent.  Principal of least
surprises, etc.

Thanks,
John
