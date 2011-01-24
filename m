From: Oliver Beattie <oliver@obeattie.com>
Subject: fatal: protocol error: bad line length 8205
Date: Mon, 24 Jan 2011 15:11:27 +0000 (UTC)
Message-ID: <loom.20110124T160907-993@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 24 16:15:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhO8R-0001iF-CZ
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 16:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035Ab1AXPPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 10:15:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:58978 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763Ab1AXPPG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 10:15:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PhO8F-0001bM-PR
	for git@vger.kernel.org; Mon, 24 Jan 2011 16:15:04 +0100
Received: from net-108.nrpn.net ([192.89.6.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Jan 2011 16:15:03 +0100
Received: from oliver by net-108.nrpn.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Jan 2011 16:15:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.89.6.108 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.237 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165450>

Hi,

I am having a bit of a weird problem with a Git server of mine I am trying to
set up. I have never had 
problems before which makes it even stranger.

Anyway, when I try to clone as a client, I get this error:
fatal: protocol error: bad line length 8205

Does anyone know what causes this/what I should do to fix it?

Many thanks,
Oliver Beattie
