From: Alexander Belchenko <bialix@ukr.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Thu, 19 Oct 2006 09:46:32 +0300
Message-ID: <eh76np$trg$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172351.17377.jnareb@gmail.com>
	<4535590C.4000004@utoronto.ca>
	<200610180057.25411.jnareb@gmail.com>
	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
	<20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Thu Oct 19 08:42:27 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaRbl-0001NZ-Sg
	for gcvbg-bazaar-ng@m.gmane.org; Thu, 19 Oct 2006 08:42:25 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GaRbk-00032j-Ln; Thu, 19 Oct 2006 07:42:24 +0100
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <gcvbg-bazaar-ng@m.gmane.org>) id 1GaRbg-00032U-Mf
	for bazaar-ng@lists.canonical.com; Thu, 19 Oct 2006 07:42:20 +0100
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GaRbd-0001LK-Lp
	for bazaar-ng@lists.canonical.com; Thu, 19 Oct 2006 08:42:17 +0200
Received: from 80.84.184.66 ([80.84.184.66])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <bazaar-ng@lists.canonical.com>; Thu, 19 Oct 2006 08:42:17 +0200
Received: from bialix by 80.84.184.66 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <bazaar-ng@lists.canonical.com>; Thu, 19 Oct 2006 08:42:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: bazaar-ng@lists.canonical.com
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 80.84.184.66
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
In-Reply-To: <20061018185225.GU20017@pasky.or.cz>
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29328>

Petr Baudis пишет:
...
> An example bundle is available at
> 
> 	http://pasky.or.cz/~pasky/cp/example-bundle.txt

You probably miss main idea of bzr bundles. It's not just the way to
send via e-mail or other appropriate transport the part of repository.
It primarily was designed to be human readable as usual diff (i.e.
patch). It was designed to solve 2 thing simultaneously:

- be informative for human as usual patch
- be consistent for machine.

--
Alexander
