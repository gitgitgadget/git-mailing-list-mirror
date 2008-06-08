From: Tzafrir Cohen <tzafrir.cohen@xorcom.com>
Subject: git-svn: multiple branches directories
Date: Sun, 8 Jun 2008 03:23:50 +0300
Organization: Xorcom*
Message-ID: <20080608002349.GB23243@xorcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 02:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K58ib-0005kl-3m
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 02:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079AbYFHAYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 20:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755097AbYFHAYS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 20:24:18 -0400
Received: from local.xorcom.com ([62.90.10.53]:59484 "EHLO local.xorcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755079AbYFHAXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 20:23:53 -0400
Received: by local.xorcom.com (Postfix, from userid 1000)
	id 3B78B5849B; Sun,  8 Jun 2008 03:23:50 +0300 (IDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84235>

Hi

Does git-svn support a repository layout where branches may reside under
more than one root?

/trunk
/branches
  branch1
  branch2
  branch3
/somedir
  branch4
  branch5
  branch6
/tags
  ...

-- 
               Tzafrir Cohen
icq#16849755              jabber:tzafrir.cohen@xorcom.com
+972-50-7952406           mailto:tzafrir.cohen@xorcom.com
http://www.xorcom.com  iax:guest@local.xorcom.com/tzafrir
