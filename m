From: Andreas Gal <gal@uci.edu>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Mon, 25 Apr 2005 21:22:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504252117510.14838@sam.ics.uci.edu>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050426040933.GA21178@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 06:18:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQHWq-0003As-L1
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 06:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVDZEXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 00:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVDZEXH
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 00:23:07 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:15299 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S261324AbVDZEWm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 00:22:42 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3Q4MAgJ014856;
	Mon, 25 Apr 2005 21:22:10 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3Q4MAd2014852;
	Mon, 25 Apr 2005 21:22:10 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20050426040933.GA21178@taniwha.stupidest.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


If adding a new arch touches 1000+ files, you're doing something 
_very_ wrong. Plus, how often did that happen in the past 10 years? 
30 times?? Probably less.

Andreas

On Mon, 25 Apr 2005, Chris Wedgwood wrote:

> On Mon, Apr 25, 2005 at 07:08:28PM -0700, Linus Torvalds wrote:
> 
> > If you're checking in a change to 1000+ files, you're doing
> > something wrong.
> 
> arch or subsystem merge?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
