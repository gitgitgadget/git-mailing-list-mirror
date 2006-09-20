From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Subversion-style incrementing revision numbers
Date: Wed, 20 Sep 2006 19:28:45 +0200
Organization: Dewire
Message-ID: <200609201928.46024.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com> <Pine.LNX.4.64.0609191416500.4388@g5.osdl.org> <20060919220604.GE8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Joel Dice <dicej@mailsnare.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 19:29:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ5sQ-00059k-9p
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 19:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWITR2r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 13:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWITR2r
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 13:28:47 -0400
Received: from [83.140.172.130] ([83.140.172.130]:9541 "EHLO torino.dewire.com")
	by vger.kernel.org with ESMTP id S932071AbWITR2q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 13:28:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 55000802883;
	Wed, 20 Sep 2006 19:26:02 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10024-04; Wed, 20 Sep 2006 19:26:02 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by torino.dewire.com (Postfix) with ESMTP id F0EA3802880;
	Wed, 20 Sep 2006 19:25:59 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.4
In-Reply-To: <20060919220604.GE8259@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27384>

onsdag 20 september 2006 00:06 skrev Petr Baudis:
[...]
> But having the commits
> numbered inside a repository would indeed make for simple usage if you
> need to type in commit ids frequently, and could make Git a bit
> friendlier to newcomers.

Typing those numbers is really insane, so the idea never occurred to me. Most 
environments have simple methods to copy and paste strings using a clipboard,
even in a console. So typically you can left-doubleclick on a string and paste 
with the middle button in *nix like systems (right button in cygwin/windows 
command line).

-- robin
