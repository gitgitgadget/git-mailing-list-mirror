From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: Problems importing SVN repo via git-svnimport
Date: Sat, 26 May 2007 15:06:43 +0200
Message-ID: <20070526130643.GA2674@planck.djpig.de>
References: <20070526125553.GC10324@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Art Haas <ahaas@airmail.net>
X-From: git-owner@vger.kernel.org Sat May 26 15:07:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrvz3-0002Ku-6J
	for gcvg-git@gmane.org; Sat, 26 May 2007 15:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbXEZNGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 09:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752887AbXEZNGr
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 09:06:47 -0400
Received: from planck.djpig.de ([85.10.192.180]:2755 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbXEZNGr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 09:06:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id E8AE4274014;
	Sat, 26 May 2007 15:06:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Ue--72Jb5t4; Sat, 26 May 2007 15:06:44 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id EA627274013; Sat, 26 May 2007 15:06:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070526125553.GC10324@artsapartment.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48471>

On Sat, May 26, 2007 at 07:55:53AM -0500, Art Haas wrote:
> I'm happy to dive into the perl code in svnimport and make changes to
> help debug this problem, if there is actually a problem and not user
> error on my part. Any help from 'svnimport' experts will be greatly
> appreciated. The public repo listed above has the same contents as my
> local repo, so feel free to poke around it to see how things are
> structured.

You might want to try git-svn instead. It should support everything you
can do with git-svnimport and much more. Plus it is actively maintained
which I wouldn't say about git-svnimport.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
