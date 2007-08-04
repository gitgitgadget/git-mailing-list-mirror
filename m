From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: core.gitproxy and non-git protocols
Date: Sat, 4 Aug 2007 01:43:29 -0400
Message-ID: <20070804054329.GO20052@spearce.org>
References: <ee77f5c20708012221j4d75ff0dl8fbf16cdaf1401bd@mail.gmail.com> <20070802053151.GH20052@spearce.org> <f90his$3tg$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 07:43:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHCQJ-0007jO-Iy
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 07:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbXHDFnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 01:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733AbXHDFnd
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 01:43:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43011 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbXHDFnc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 01:43:32 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHCQD-0007TG-JH; Sat, 04 Aug 2007 01:43:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 91AF020FBAE; Sat,  4 Aug 2007 01:43:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <f90his$3tg$2@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54794>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
> > 
> > Did you try setting GIT_SSH envvar to point to a script that does
> > what you need?  I do this in one particular case...
> 
> GIT_SSH environmental variable is *not described* anywhere in the
> documentation. Would you be so kind?

Whow.  It really isn't documented.

OK, I'll send a documentation patch in a few minutes.

-- 
Shawn.
