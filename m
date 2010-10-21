From: Jonas <jonas@ibiz.se>
Subject: Re: git repository in production release
Date: Thu, 21 Oct 2010 14:03:46 +0000 (UTC)
Message-ID: <loom.20101021T160058-462@post.gmane.org>
References: <loom.20101021T140249-924@post.gmane.org> <1287664757.24161.17.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 16:04:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8vkW-00069u-8K
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 16:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197Ab0JUOEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 10:04:01 -0400
Received: from lo.gmane.org ([80.91.229.12]:59935 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756881Ab0JUOEB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 10:04:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P8vkM-00067B-4g
	for git@vger.kernel.org; Thu, 21 Oct 2010 16:03:58 +0200
Received: from static-92-33-15-10.sme.bredbandsbolaget.se ([92.33.15.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 16:03:58 +0200
Received: from jonas by static-92-33-15-10.sme.bredbandsbolaget.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 16:03:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.33.15.10 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; sv-se) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159506>

Because I suspect that the local .git directory in my rails application 
folder should not be added to the 
remote repository at all. But I might be wrong.
