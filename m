From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] git-blame and git-gui blame wishlist
Date: Mon, 3 Sep 2007 23:25:50 -0400
Message-ID: <20070904032550.GT18160@spearce.org>
References: <200709031240.04235.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Costalba <mcostalba@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 05:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISP3G-0002kf-FT
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 05:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbXIDD0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 23:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbXIDD0A
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 23:26:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57167 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbXIDD0A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 23:26:00 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ISP2n-0005Pc-PB; Mon, 03 Sep 2007 23:25:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B32F020FBAE; Mon,  3 Sep 2007 23:25:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200709031240.04235.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57514>

Jakub Narebski <jnareb@gmail.com> wrote:
> 1. In git-gui blame viewer you can click on shortened sha1 of a commit
...
> 2. Sometimes I'm interested only in part of a file. Thus I'd like
...
> 3. Sometimes when reviewing patches I do wonder: why the preimage looks
...

I've seen this list before... hmm, yea, I have, right here:

	From: Jakub Narebski <jnareb@gmail.com>
	To: git@vger.kernel.org
	Subject: git-blame and blame GUI wishlist
	Date: Mon, 6 Aug 2007 00:09:37 +0200
	Message-Id: <200708060009.37595.jnareb@gmail.com>

;-)

To the extent that I can get around to it, it has been on my todo
list.  But you have to keep in mind that my todo list for git is
very, very, very long and my time to work on it is quite limited
in comparsion.

I certainly would not mind if more folks helped out on git-gui by
contributing patches to it.  :)

Unfortunately the survey results seem to indicate that not many of
our users know Tcl/Tk.  Yea, it is a somewhat weird language, but
there's books and other documentation available for free through
a series tubes that Mr. Gore invented.  Most programmers can pick
up Tcl.  They just might want to hurt themselves afterwards...

-- 
Shawn.
