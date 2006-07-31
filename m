From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Diff format in packs
Date: Mon, 31 Jul 2006 23:16:19 +0200
Organization: At home
Message-ID: <ealruh$sq9$1@sea.gmane.org>
References: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 31 23:16:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7f7j-00034F-2j
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 23:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWGaVQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 17:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWGaVQX
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 17:16:23 -0400
Received: from main.gmane.org ([80.91.229.2]:31373 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751211AbWGaVQW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 17:16:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7f7Y-00032R-2a
	for git@vger.kernel.org; Mon, 31 Jul 2006 23:16:16 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 23:16:16 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 23:16:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24545>

Jon Smirl wrote:

> I'm trying to build a small app that takes a CVS ,v and writes out a
> pack corresponding to the versions. Suggestions on the most efficient
> strategy for doing this by calling straight into the git C code?
> Forking off git commands is not very efficient when done a million
> times.

Something akin to parsecvs by Keith Packard?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
