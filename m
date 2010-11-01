From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git-gui appears to not respect Windows 7 settings on Display
 Language.
Date: Mon, 1 Nov 2010 03:23:34 +0300
Message-ID: <20101101002334.GF18845@localhost.localdomain>
References: <AANLkTin6jP0N4gbiNU3=h0eYrYSOj-e65JfWS5tf1iSd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Menegakis <arxeio@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 01:26:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCiEg-0007mj-Md
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 01:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab0KAAXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 20:23:40 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:57311 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab0KAAXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 20:23:39 -0400
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oA10NZWQ023361;
	Mon, 1 Nov 2010 03:23:36 +0300
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 3AD1B45A220; Mon,  1 Nov 2010 03:23:35 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <AANLkTin6jP0N4gbiNU3=h0eYrYSOj-e65JfWS5tf1iSd@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160457>

On Sun, Oct 31, 2010 at 09:53:37PM +0200, Michael Menegakis wrote:

> For some unknown sorcery Microsoft does not refer to 'Locale' the same
> as UNIX. There is only a display-characters method, only if a
> character set is not unicode. For actual display of language they have
> now on 7 a package downloading mechanism to have the whole system show
> a language.
> 
> On 7 right now I have locale on Greek so that any non-unicode programs
> will work with that. But the display language is English and no Greek
> or other non-English package has been installed. The location is also
> Greece but that doesn't affect other programs either.
> 
> In general these settings make almost all programs to display English
> by default. Only a minority like git-gui don't.
I suggest you raising this question on the msysgit mailing list [1]
or file a bug to its tracker.

1. http://groups.google.com/group/msysgit/
