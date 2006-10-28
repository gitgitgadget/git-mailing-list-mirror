X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Jakub Narebski <jnareb@gmail.com>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: VCS comparison table
Date: Sat, 28 Oct 2006 16:58:10 +0200
Organization: At home
Message-ID: <ehvr4h$69g$1@sea.gmane.org>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl>
	<4541D291.5020205@op5.se> <20061027144656.GA32451@fieldses.org>
	<m3mz7gheoe.fsf@iny.iki.fi> <ehvnal$tjg$1@sea.gmane.org>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: sea.gmane.org 1162047543 9512 80.91.229.2 (28 Oct 2006 14:59:03 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Sat, 28 Oct 2006 14:59:03 +0000 (UTC)
Cc: git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 28 16:59:01 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GdpeH-0001mx-7a
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 28 Oct 2006 16:59:01 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GdpdD-0000E2-Br; Sat, 28 Oct 2006 15:57:55 +0100
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <gcvbg-bazaar-ng@m.gmane.org>) id 1GdpdA-0000Dm-Q1
	for bazaar-ng@lists.canonical.com; Sat, 28 Oct 2006 15:57:52 +0100
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gdpcz-0001aW-3f
	for bazaar-ng@lists.canonical.com; Sat, 28 Oct 2006 16:57:42 +0200
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <bazaar-ng@lists.canonical.com>; Sat, 28 Oct 2006 16:57:41 +0200
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <bazaar-ng@lists.canonical.com>; Sat, 28 Oct 2006 16:57:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: bazaar-ng@lists.canonical.com
Original-Followup-To: gmane.comp.version-control.bazaar-ng.general
Original-Lines: 17
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
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
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:18928 gmane.comp.version-control.git:30380
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30380>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski wrote:

>> You can't just diff branchA/foo branchB/foo.
> 
> You can: either using "git diff branchA branchB -- foo" which means
> difference between branches branchA and branchB limited to the differences
> on branch foo (where foo can be directory name or filename)

Sorry, it should be:

"limited to the differences on pathname foo (where foo can be directory name
or filename)"

