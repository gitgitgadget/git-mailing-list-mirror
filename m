From: Petr Baudis <pasky@suse.cz>
Subject: Re: [CFH] Broken permissions in repo.or.cz repositories
Date: Fri, 11 Jul 2008 01:19:45 +0200
Message-ID: <20080710231945.GD32184@machine.or.cz>
References: <56a0a2840807101218n7a280b67gfb3c579ada6b0e02@mail.gmail.com> <20080710230058.GQ10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jesper Louis Andersen <jesper.louis.andersen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 01:20:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5RS-0004rO-IZ
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbYGJXTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 19:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbYGJXTu
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:19:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50091 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752493AbYGJXTu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 19:19:50 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 939DE2C4C033; Fri, 11 Jul 2008 01:19:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080710230058.GQ10151@machine.or.cz>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88052>

  Hi,

On Fri, Jul 11, 2008 at 01:00:58AM +0200, Petr Baudis wrote:
>   turns out current git has buggy handling of the sharedRepository
> config parameter, resulting in permission problems. Hopefully fixed.

  sorry, this was not supposed to be cc'd to the mailing list in the
end, and is not CFH anymore. I'm trying to send a patch to the mailing
list now. :-)

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
