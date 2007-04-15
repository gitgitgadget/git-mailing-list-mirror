From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Document -g (--walk-reflogs) option of git-log
Date: Mon, 16 Apr 2007 01:12:12 +0200
Message-ID: <20070415231212.GD4417@steel.home>
References: <20070415223606.GB4417@steel.home> <7v3b312q9k.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:12:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdDtK-0005Su-HM
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbXDOXMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbXDOXMP
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:12:15 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:57151 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbXDOXMO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:12:14 -0400
Received: from tigra.home (Fcb1d.f.strato-dslnet.de [195.4.203.29])
	by post.webmailer.de (mrclete mo64) (RZmta 5.5)
	with ESMTP id G058a7j3FMQHeM ; Mon, 16 Apr 2007 01:12:12 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9406D277BD;
	Mon, 16 Apr 2007 01:12:12 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 6E99FD439; Mon, 16 Apr 2007 01:12:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3b312q9k.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg2oA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44543>

Junio C Hamano, Mon, Apr 16, 2007 01:04:39 +0200:
> > +	See also gitlink:git-ref-log[1].
> Thanks.  I'll fix this up with s/ref-log/reflog/.

Oh, thanks.
