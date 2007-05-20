From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Commit ID in exported Tar Ball
Date: Sun, 20 May 2007 18:30:26 +0200
Message-ID: <20070520163026.GA7387@cip.informatik.uni-erlangen.de>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <20070520161048.GI5015@cip.informatik.uni-erlangen.de> <817CD103-261C-4D40-9C8F-00B2E14130BE@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun May 20 18:31:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpoJ9-0000dX-38
	for gcvg-git@gmane.org; Sun, 20 May 2007 18:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758161AbXETQa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 12:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758759AbXETQa3
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 12:30:29 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:41201 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758161AbXETQa2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2007 12:30:28 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id C50E63F3DC; Sun, 20 May 2007 18:30:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <817CD103-261C-4D40-9C8F-00B2E14130BE@silverinsanity.com>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47855>

Hello,

> For version information it is far more useful to use --tags or no options 
> (annotated tags only) instead of --all.

so this output is useless if you don't have tagged the commit which
isn't the case. But thanks for the awareness.

        Thomas
