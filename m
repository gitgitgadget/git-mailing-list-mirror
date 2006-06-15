From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 20:03:56 +0200
Organization: At home
Message-ID: <e6s7eb$78h$1@sea.gmane.org>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth> <20060615133146.GA5794@steel.home> <20060615163209.GJ7766@nowhere.earth> <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org> <20060615174833.GA32247@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 15 20:04:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqwCm-00086N-96
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 20:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030910AbWFOSEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 14:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030935AbWFOSEY
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 14:04:24 -0400
Received: from main.gmane.org ([80.91.229.2]:58854 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030910AbWFOSEX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 14:04:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FqwCT-00083J-B7
	for git@vger.kernel.org; Thu, 15 Jun 2006 20:04:13 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jun 2006 20:04:13 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jun 2006 20:04:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21899>

Olivier Galibert wrote:

> On Thu, Jun 15, 2006 at 10:02:10AM -0700, Linus Torvalds wrote:
>> These days, there aren't fifteen different versions of UNIX. There's a 
>> couple, and it's perfectly ok to actually say "fix your damn system and 
>> just install GNU make". It's easier to install GNU make than it is to 
>> install autoconf/automake.
> 
> You should be careful to separate autoconf and automake.  Autoconf is
> not so bad, and you can make clean, maintainable Makefile.in and
> config.h.in files with it, because it uses simple substitution.
[...]
> So, autoconf can be useful.  The rest should die.

Does autoconf generate configure script in POSIX shell, or in bash?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
