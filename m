From: Walter Bright <boost@digitalmars.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 15:54:05 -0700
Organization: Digital Mars
Message-ID: <fbskq5$6le$1@sea.gmane.org>
References: <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <20070907094120.GA27754@artemis.corp> <fbs79k$tac$1@sea.gmane.org> <20070907194115.GA23483@artemis.corp> <fbsd0g$gt6$1@sea.gmane.org> <20070907205604.GC23483@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 00:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITmiU-0006fQ-OR
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 00:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbXIGWyR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 18:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbXIGWyR
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 18:54:17 -0400
Received: from main.gmane.org ([80.91.229.2]:49801 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbXIGWyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 18:54:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITmiH-00036j-0K
	for git@vger.kernel.org; Sat, 08 Sep 2007 00:54:09 +0200
Received: from c-24-16-50-251.hsd1.wa.comcast.net ([24.16.50.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Sep 2007 00:54:08 +0200
Received: from boost by c-24-16-50-251.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Sep 2007 00:54:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-50-251.hsd1.wa.comcast.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070907205604.GC23483@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58089>

Pierre Habouzit wrote:
>   Sure, but it does not works on amd64 properly (and it's the
> architecture I care about) and is not ready for the current gcc (4.2,
> only 4.1 builds) and so on. It's not as stable as DMD is. It does not
> lags too much version-wise, it lags in maturity. But well, youth has a
> cure: time :)

Yes, and the more people use it, the better it will get. These are all 
environmental problems, not technical limitations of the language.
