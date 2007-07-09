From: David Kastrup <dak@gnu.org>
Subject: "svn switch" equivalent when using git-svn -- git-filter-branch?
Date: Mon, 09 Jul 2007 14:36:25 +0200
Message-ID: <86sl7x7nzq.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 14:36:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7sTs-0005lu-Af
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 14:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbXGIMgi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 08:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbXGIMgi
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 08:36:38 -0400
Received: from main.gmane.org ([80.91.229.2]:47912 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbXGIMgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 08:36:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I7sTh-0002AA-Ow
	for git@vger.kernel.org; Mon, 09 Jul 2007 14:36:33 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 14:36:33 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 14:36:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:yCIdHjmZUhUCJdic8/Q/fecbHXA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51987>


Hi,

an upstream svn repository that I access with git-svn has moved.  I
seem to be too stupid to use git-filter-branch and/or .git/config
and/or git-reset to make my git mirror follow the switch.

Any pointers?

-- 
David Kastrup
