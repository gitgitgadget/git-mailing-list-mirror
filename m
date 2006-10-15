From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: svn revision id in git commit?
Date: Sun, 15 Oct 2006 22:25:57 +0200
Organization: Dewire
Message-ID: <200610152225.58744.robin.rosenberg.lists@dewire.com>
References: <egtpe4$i8v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 22:25:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZCY1-0006FF-8K
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 22:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422891AbWJOUZQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 15 Oct 2006 16:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWJOUZQ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 16:25:16 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14435 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1030264AbWJOUZO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 16:25:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id D663B8028A6;
	Sun, 15 Oct 2006 22:22:09 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03220-01; Sun, 15 Oct 2006 22:22:09 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id 8D7988028A2;
	Sun, 15 Oct 2006 22:22:07 +0200 (CEST)
To: "Anand Kumria" <wildfire@progsoc.org>
User-Agent: KMail/1.9.4
In-Reply-To: <egtpe4$i8v$1@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28933>

s=C3=B6ndag 15 oktober 2006 18:59 skrev Anand Kumria:
> Hi,
>
> I'm using git-svnimport with great success; generally when I do a mer=
ge
> from the subversion (via git-svnimport) I tag the revision number I m=
erge
> up to.

The -r flags adds the subversion revision to the commit message. It's i=
n the=20
man page.

BTW, you may want to look at git-svn if you are shadowing a subversion =
repo.=20
It adds then subversion revision by default. Neither creates a tag thou=
gh.

-- robin
