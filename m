From: Uri Okrent <uokrent@gmail.com>
Subject: Re: [PATCH] Fix overridable written with an extra 'e'
Date: Sun, 30 Aug 2009 17:58:26 +0000 (UTC)
Message-ID: <loom.20090830T195508-894@post.gmane.org>
References: <20090828121849.6117@nanako3.lavabit.com> <20090828034305.GQ4297@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 30 20:00:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhohQ-0007cV-2C
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 20:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbZH3SAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 14:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbZH3SAF
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 14:00:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:47159 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753514AbZH3SAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 14:00:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MhohA-0007a9-5o
	for git@vger.kernel.org; Sun, 30 Aug 2009 20:00:04 +0200
Received: from cpe-76-90-28-9.socal.res.rr.com ([76.90.28.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 20:00:04 +0200
Received: from uokrent by cpe-76-90-28-9.socal.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 20:00:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 76.90.28.9 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127418>

Todd Zullinger <tmz <at> pobox.com> writes:

> 
> Nanako Shiraishi wrote:
> > Found during the lunch break by one of my students...
> 
> Is overridable a word itself?  While English is my native language, I
> wouldn't call myself an expert on its proper usage. ;)

No, it's not a word =). But of the two non-words, overridable is probably
preferred.

> 
> However, I can't find 'overridable' in several online dictionaries:
> 
> http://dictionary.reference.com/browse/overridable
> http://www.merriam-webster.com/dictionary/overridable
> http://www.google.com/dictionary?aq=f&langpair=en|en&q=overridable&hl=en
> http://dictionary.cambridge.org/results.asp?searchword=overridable&x=0&y=0
> 
> Perhaps using overridden would be more accurate?

It would be more correct, but also slightly more verbose. Still, as a grammar
nazi, my two cents says it raises git's esteem if the language in the docs is
proper English.

Uri
