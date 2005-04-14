From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] git-pasky-0.4
Date: Thu, 14 Apr 2005 02:19:38 +0200
Message-ID: <20050414001938.GR25711@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 14 02:20:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLs5q-0004tr-4a
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 02:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVDNAXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 20:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVDNAUa
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 20:20:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9914 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261248AbVDNATn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 20:19:43 -0400
Received: (qmail 1917 invoked by uid 2001); 14 Apr 2005 00:19:38 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  I'm happy to announce git-pasky-0.4, my set of scripts upon Linus
Torvald's git, which aims to provide a humanly usable interface, to a
degree similar to a SCM tool. You can get it at

	http://pasky.or.cz/~pasky/dev/git/

  See the READMEs etc for some introduction.

  It is difficult to sum up the changes, since so much has changed,
including almost the complete tree history, which was cleaned up and
sanitized. Things should be faster, better, less buggy and generally
smoother.

  My immediate plans are to support several working trees connected to a
single object database. The scenes are set, prepared, and it should be
easy. Then, supporting merges in a separate temporary tree will be a
breeze. ;-)

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
