From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git svn --stdlayout 's little quirk.
Date: Tue, 23 Aug 2011 08:09:27 +0200
Message-ID: <20110823060927.GA26358@inner.h.iocl.org>
References: <1314025898.45043.YahooMailClassic@web29503.mail.ird.yahoo.com> <4E52759E.3020005@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: htl10@users.sourceforge.net, Eric Wong <normalperson@yhbt.net>,
	madduck@madduck.net, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 23 08:09:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvkBP-0002cn-G3
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 08:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab1HWGJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 02:09:51 -0400
Received: from continuum.iocl.org ([217.140.74.2]:38047 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1HWGJu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 02:09:50 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id p7N69SK27012;
	Tue, 23 Aug 2011 08:09:28 +0200
Content-Disposition: inline
In-Reply-To: <4E52759E.3020005@drmicha.warpmail.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179922>

On Mon, 22 Aug 2011 17:28:30 +0000, Michael J Gruber wrote:
...
> You *could* have this layout:
> 
> foo/trunk/trunk
> foo/trunk/tags/v1
> foo/trunk/tags/v2

We *do*. Ok, it's more like dev/trunk/mod/submod/trunk (and sometimes with
even more trunks). Stupid historical accident.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
