From: Derek <darek.dade@gmail.com>
Subject: GIT 1.5.4.2 installation on Solaris 8 problems
Date: Fri, 20 Nov 2009 18:50:13 +0000 (UTC)
Message-ID: <loom.20091120T194807-826@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 19:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBYdV-0000Mw-A0
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 19:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbZKTSzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 13:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbZKTSy7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 13:54:59 -0500
Received: from lo.gmane.org ([80.91.229.12]:44727 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219AbZKTSy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 13:54:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NBYdM-0000H8-Lb
	for git@vger.kernel.org; Fri, 20 Nov 2009 19:55:04 +0100
Received: from DMOCJZ ([DMOCJZ])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 19:55:04 +0100
Received: from darek.dade by DMOCJZ with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 19:55:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 206.47.249.252 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.15) Gecko/2009101601 Firefox/3.0.15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133364>

I get the following error after make install:

install: git-fetch-pack was not found anywhere!
make: *** [install] Error 2

Any ideas?
