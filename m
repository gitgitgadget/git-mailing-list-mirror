From: Thomas Hochstein <thh@inter.net>
Subject: Re: SVN -> Git *but* with special changes
Date: Sun, 08 Jan 2012 12:24:16 +0100
Message-ID: <gcvg.1201081224.65@landroval.ancalagon.de>
References: <1317227849979-6840904.post@n2.nabble.com> <20110928190445.GC1482@sigill.intra.peff.net> <1325999031923-7163706.post@n2.nabble.com> <20120108051051.GA10129@sigill.intra.peff.net> <1325999865995-7163737.post@n2.nabble.com> <1326000327637-7163752.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 14:05:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjsRd-00064f-7L
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 14:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab2AHNFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 08:05:33 -0500
Received: from lo.gmane.org ([80.91.229.12]:39806 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388Ab2AHNFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 08:05:32 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RjsRH-0005sc-FQ
	for git@vger.kernel.org; Sun, 08 Jan 2012 14:05:31 +0100
Received: from p4fcce763.dip.t-dialin.net ([79.204.231.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 14:05:31 +0100
Received: from thh by p4fcce763.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 14:05:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4fcce763.dip.t-dialin.net
User-Agent: ForteAgent/6.00-32.1186  Hamster/2.1.0.11
X-Uptime: 2 day(s), 17 hour(s), 33 minute(s), 11 second(s) [landroval | 66535]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188114>

Abscissa wrote:

> Well that's strange, it finished "upgrading", but now git is still just
> reporting 1.7.0.4, which is *exactly* the same version it said before. 

What kind of distribution do you use?

"apt-get" sounds like Debian or Ubuntu, but those all have at least
git 1.7.1:

| Debian versions:
| stable      1:1.7.2.5-3 
| stable-bpo  1:1.7.7.3-1~bpo60+2 
| testing     1:1.7.7.3-1 
| unstable    1:1.7.8.2-1 
| exp         1:1.7.8~rc3-1 

| Ubuntu versions:
| Precise Pangolin  1:1.7.7.3-1
| Oneiric Ocelot    1:1.7.5.4-1
| Natty Narwhal     1:1.7.4.1-3
| Maverick Meerkat  1:1.7.1-1.1ubuntu0.1

-thh
