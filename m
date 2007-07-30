From: David Kastrup <dak@gnu.org>
Subject: "git stash" is not known to git
Date: Mon, 30 Jul 2007 11:22:07 +0200
Message-ID: <86bqduutz4.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 11:23:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFRTI-000211-UG
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 11:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933629AbXG3JXU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 05:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933317AbXG3JXU
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 05:23:20 -0400
Received: from main.gmane.org ([80.91.229.2]:47181 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765937AbXG3JXS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 05:23:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFRSg-00078R-Er
	for git@vger.kernel.org; Mon, 30 Jul 2007 11:22:46 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 11:22:46 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 11:22:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:f25MRK+AxrvnycaMSE+jJcVYyKw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54213>


One has to use git-stash rather than "git stash".  Oversight?

-- 
David Kastrup
