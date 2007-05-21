From: David Kastrup <dak@gnu.org>
Subject: git-svn or git problem...
Date: Mon, 21 May 2007 09:54:24 +0200
Message-ID: <86abvylihb.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 09:54:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq2j5-0003Zb-HP
	for gcvg-git@gmane.org; Mon, 21 May 2007 09:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955AbXEUHyh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 03:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755111AbXEUHyh
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 03:54:37 -0400
Received: from main.gmane.org ([80.91.229.2]:43498 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754955AbXEUHyh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 03:54:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hq2iv-0006Vq-Py
	for git@vger.kernel.org; Mon, 21 May 2007 09:54:33 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 May 2007 09:54:33 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 May 2007 09:54:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:3cvn+2CQt5aybKXI7JkQj0Tyd00=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47989>


Hi,

I have used git-svn for checking out the trunk of a large Subversion
archive.  The .git subdirectory now sits in the /rep/texlive/trunk
directory.

But I actually would now want to have the branches (which are pretty
small in comparison) available in git as well, without checking the
whole trunk out again.

Is there a way to move the .git tracking one directory level upwards
and get the branches into it as well, without checking out the trunk
again (the trunk is several Gigabytes of size)?

-- 
David Kastrup
