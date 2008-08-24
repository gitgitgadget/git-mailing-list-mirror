From: Tommi Virtanen <tv@eagain.net>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Sun, 24 Aug 2008 23:38:25 +0300
Message-ID: <20080824203825.GB14930@eagain.net>
References: <20080824202325.GA14930@eagain.net> <7vfxoukv56.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 22:39:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXMN1-0003ha-Me
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 22:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbYHXUi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 16:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbYHXUi1
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 16:38:27 -0400
Received: from eagain.net ([208.78.102.120]:57571 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095AbYHXUi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 16:38:27 -0400
Received: from musti.eagain.net (a91-156-122-108.elisa-laajakaista.fi [91.156.122.108])
	by eagain.net (Postfix) with ESMTPS id E9FA71EC039;
	Sun, 24 Aug 2008 20:38:26 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id 83455508695; Sun, 24 Aug 2008 23:38:25 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7vfxoukv56.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93565>

On Sun, Aug 24, 2008 at 01:36:37PM -0700, Junio C Hamano wrote:
> Of course it would.  Does using /usr/libexec/git-core/git-shell work?

It would, but do you really want people using that?

-- 
:(){ :|:&};:
