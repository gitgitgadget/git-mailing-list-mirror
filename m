From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/4] diff text conversion filter
Date: Mon, 06 Oct 2008 00:03:48 +0200
Organization: At home
Message-ID: <gcbdk1$kpe$1@ger.gmane.org>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr> <20080928041040.GA24214@coredump.intra.peff.net> <vpqd4io1tla.fsf@bauges.imag.fr> <20080928161106.GA30199@coredump.intra.peff.net> <vpqk5ctfyp6.fsf@bauges.imag.fr> <20080930164545.GA20305@sigill.intra.peff.net> <20081005214114.GA21875@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 00:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmbis-0006fw-H4
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 00:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085AbYJEWD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 18:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754967AbYJEWD4
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 18:03:56 -0400
Received: from main.gmane.org ([80.91.229.2]:38130 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754887AbYJEWDz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 18:03:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kmbhh-0008ST-NM
	for git@vger.kernel.org; Sun, 05 Oct 2008 22:03:53 +0000
Received: from abwo50.neoplus.adsl.tpnet.pl ([83.8.238.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 22:03:53 +0000
Received: from jnareb by abwo50.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 22:03:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwo50.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97543>

Jeff King wrote:

> On Tue, Sep 30, 2008 at 12:45:45PM -0400, Jeff King wrote:
> 
>> I am about 90% done cleaning it up for preparation (there is a bit of
>> refactoring, and I want to make sure I get that just right). I'll post
>> it in the next day or so.
> 
> Sorry, I didn't get a chance to look at this until today. Patch series
> will follow. It is still missing documentation updates and tests, but I
> wanted to get you something to look at (and as I am proposing a new
> meaning for "diff driver", I would be curious to hear the general
> comments).
> 
> This is on top of 'next', because it would otherwise conflict with the
> funcname pattern changes there.

Documentation, pretty please?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
