From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: git maintenance bug tracker sooner better than later
Date: Fri, 6 Feb 2009 16:30:16 +0000 (UTC)
Message-ID: <slrngoopcn.14u8.heipei@macbook.lan>
References: <498C3362.9080105@op5.se> <87skmrhf5i.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 17:31:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVTcR-0006Ao-RA
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbZBFQa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 11:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbZBFQa2
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 11:30:28 -0500
Received: from main.gmane.org ([80.91.229.2]:43505 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbZBFQa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 11:30:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVTb0-0006Ee-Bw
	for git@vger.kernel.org; Fri, 06 Feb 2009 16:30:26 +0000
Received: from p5082fbda.dip.t-dialin.net ([80.130.251.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 16:30:26 +0000
Received: from heipei by p5082fbda.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 16:30:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5082fbda.dip.t-dialin.net
User-Agent: slrn/0.9.9p1 (Darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108759>

On 2009-02-06, jidanni@jidanni.org <jidanni@jidanni.org> wrote:
> With a bug tracker, at least one knows somebody saw something for
> sure, and it didn't just float by. That way one could register items
> into it on one's good days, and then take a break, which I am going to
> do now. Thanks.

And what "bugs" would you file? If I look at your patch-series which 
consists of oneliner documentation nitpicking, I don't even want to 
imagine how much these would get blown up by a web-based bug-tracker.

The web-based is the second part: When working on/with *git*, a 
command-line tool, I naturally work in a terminal, and I *don't* want to 
fire up a webbrowser to communicate something as simple as a bug. Also 
bug-trackers tend to attract all sorts of people who don't really think 
or try to find bugs before submitting them. Those sorts of people 
probably already file bugs for git and the distribution-maintainers then 
tell them to report the problem upstream (i.e.: here) or do it 
themselves.

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
