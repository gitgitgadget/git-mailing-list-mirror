From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Wed, 11 Feb 2009 01:22:51 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngp4a3b.ual.sitaramc@sitaramc.homelinux.net>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
 <etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil>
 <slrngp21uj.i22.sitaramc@sitaramc.homelinux.net>
 <1234295272.10335.26.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 02:24:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX3q0-0006Bv-A2
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 02:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbZBKBXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 20:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbZBKBXA
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 20:23:00 -0500
Received: from main.gmane.org ([80.91.229.2]:35740 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415AbZBKBXA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 20:23:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LX3oZ-0007kN-OQ
	for git@vger.kernel.org; Wed, 11 Feb 2009 01:22:59 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 01:22:59 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 01:22:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109364>

On 2009-02-10, Jon Loeliger <jdl@freescale.com> wrote:
> On Tue, 2009-02-10 at 04:51 +0000, Sitaram Chamarty wrote:
>
>> I use cross-branch stashes all the time.  Stash it here, go
>> there, and pop the stash.  I hope that does not change :-)
>
> Perhaps 'git checkout -m other_branch'?

Aaah -- thanks!  I should have known there'd be an easier
way... :-)
