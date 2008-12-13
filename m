From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe+git@gmail.com>
Subject: Re: Saving patches from this list
Date: Sat, 13 Dec 2008 13:28:19 +0000 (UTC)
Message-ID: <loom.20081213T132458-8@post.gmane.org>
References: <loom.20081212T072326-350@post.gmane.org> <49421AEE.8090902@viscovery.net> <loom.20081212T082629-274@post.gmane.org> <e2b179460812120107t74a4a8e3y1654233fe2870ac7@mail.gmail.com> <20081212151419.GL32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 14:30:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBUZQ-0008Hg-I1
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 14:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbYLMN2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 08:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbYLMN2f
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 08:28:35 -0500
Received: from main.gmane.org ([80.91.229.2]:44889 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbYLMN2e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 08:28:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LBUXl-0002xO-H9
	for git@vger.kernel.org; Sat, 13 Dec 2008 13:28:29 +0000
Received: from dyndsl-095-033-076-202.ewe-ip-backbone.de ([95.33.76.202])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 13:28:29 +0000
Received: from stefan.naewe+git by dyndsl-095-033-076-202.ewe-ip-backbone.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 13:28:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 95.33.76.202 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.4) Gecko/2008111317 Ubuntu/8.04 (hardy) Firefox/3.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102998>

Shawn O. Pearce <spearce <at> spearce.org> writes:

> > > > > What's the best way to get patches sent to this list in a form suitable
> > > > > for 'git am' without subscribing to this list ?
> 
> If you find the article on the web with gmane, add '/raw' onto the
> end of direct link URL.  E.g. to get:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/102874
> 
> use:
> 
>   curl http://article.gmane.org/gmane.comp.version-control.git/102874/raw |
git am 

Now that was helpful!
Exactly what I was looking for!


Thanks,
Stefan
