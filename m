From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Remove redundant "commit" link from shortlog
Date: Fri, 6 Oct 2006 15:55:08 +0200
Message-ID: <20061006135508.GO20017@pasky.or.cz>
References: <20060928234840.25950.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 15:55:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVqAU-0001e3-9q
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 15:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWJFNzL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 09:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422681AbWJFNzL
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 09:55:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56043 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422669AbWJFNzJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 09:55:09 -0400
Received: (qmail 5800 invoked by uid 2001); 6 Oct 2006 15:55:08 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060928234840.25950.qmail@web31809.mail.mud.yahoo.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28403>

Dear diary, on Fri, Sep 29, 2006 at 01:48:40AM CEST, I got a letter
where Luben Tuikov <ltuikov@yahoo.com> said that...
> Remove the redundant "commit" link from shortlog.
> It can be had by simply clicking on the entry title
> of the row.
> 
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>

And what if the commit message is empty?

Witness at http://repo.or.cz/?p=test;a=summary

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
