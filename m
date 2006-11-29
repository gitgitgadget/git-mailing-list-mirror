X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 11:52:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45357CC3.4040507@utoronto.ca>
	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	<87slhcz8zh.wl%cworth@cworth.org>
	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
	<20061026101038.GA13310@coredump.intra.peff.net>
	<877iyne4dm.fsf@alplog.fr>
	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
	<456B7C6A.80104@webdrake.net>
	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
	<ekhaeg$etk$1@sea.gmane.org>
	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>
	<456C7592.6020700@ableton.com>
	<ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de>
	<456CA981.4010808@onlinehome.de>
	<Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
	<456CB197.2030201@onlinehome.de>
	<Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Trace: sea.gmane.org 1164797565 6325 80.91.229.2 (29 Nov 2006 10:52:45 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Wed, 29 Nov 2006 10:52:45 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
Original-X-From: bazaar-ng-bounces@lists.canonical.com Wed Nov 29 11:52:43 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GpN3Q-0002Su-Ft
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 29 Nov 2006 11:52:40 +0100
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GpN3N-0000fP-1z; Wed, 29 Nov 2006 10:52:37 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by esperanza.ubuntu.com with smtp (Exim 4.60)
	(envelope-from <Johannes.Schindelin@gmx.de>) id 1GpN39-0000fK-4r
	for bazaar-ng@lists.canonical.com; Wed, 29 Nov 2006 10:52:24 +0000
Received: (qmail invoked by alias); 29 Nov 2006 10:52:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
	[132.187.25.13]
	by mail.gmx.net (mp031) with SMTP; 29 Nov 2006 11:52:23 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
X-Y-GMX-Trusted: 0
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
Original-Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:19830 gmane.comp.version-control.git:32631
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32631>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 28 Nov 2006, Linus Torvalds wrote:

> On Tue, 28 Nov 2006, Nicholas Allen wrote:
> > 
> > All useful conflict status is lost isn't it?
> 
> No, it's actually there, but "git status" doesn't really explain it to 
> you.
> 
> The go-to command tends to be "git diff", which after a merge will not 
> show anything that already merged correctly (because it will have been 
> updated in the git index _and_ updated in the working tree, so there will 
> be no diff from stuff that auto-merged).

This is actually the most meaningful argument for not hiding the index. 
Usually I explain it to people as a "staging area" standing between your 
working directory, and the next committed state.

But I will start explaining the index with "what if your merge failed?".

Ciao,
Dscho




