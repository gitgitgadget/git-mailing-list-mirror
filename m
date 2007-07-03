From: David Kastrup <dak@gnu.org>
Subject: Re: being nice to patch(1)
Date: Tue, 03 Jul 2007 15:54:28 +0200
Message-ID: <86hcolr3sb.fsf@lola.quinscape.zz>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
	<20070702142557.eba61ccd.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
	<20070702145601.a0dcef0f.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
	<7vhcomuofl.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org>
	<Pine.LNX.4.64.0707031303130.4071@racer.site>
	<86y7hxr591.fsf@lola.quinscape.zz>
	<Pine.LNX.4.64.0707031437560.4071@racer.site>
Reply-To: quilt-dev@nongnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: quilt-dev@nongnu.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org Tue Jul 03 16:34:51 2007
connect(): Connection refused
Return-path: <quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org>
Envelope-to: gcvqd-quilt-dev@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5jSr-0000E4-71
	for gcvqd-quilt-dev@m.gmane.org; Tue, 03 Jul 2007 16:34:49 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1I5jSq-0002CY-M3
	for gcvqd-quilt-dev@m.gmane.org; Tue, 03 Jul 2007 10:34:48 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1I5ipr-000831-Sj
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 09:54:31 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1I5ipr-00082X-3x
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 09:54:31 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1I5ipq-00082S-Vd
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 09:54:31 -0400
Received: from pc3.berlin.powerweb.de ([62.67.228.11])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>) id 1I5ipq-0001g0-E2
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 09:54:30 -0400
Received: from quinscape.de (dslnet.212-29-44.ip210.dokom.de [212.29.44.210]
	(may be forged))
	by pc3.berlin.powerweb.de (8.9.3p3/8.9.3) with ESMTP id PAA23452
	for <quilt-dev@nongnu.org>; Tue, 3 Jul 2007 15:54:22 +0200
X-Delivered-To: <quilt-dev@nongnu.org>
Received: (qmail 31881 invoked from network); 3 Jul 2007 13:54:28 -0000
Received: from unknown (HELO lola.quinscape.zz) ([10.0.3.43])
	(envelope-sender <dak@gnu.org>)
	by ns.quinscape.de (qmail-ldap-1.03) with SMTP
	for <Johannes.Schindelin@gmx.de>; 3 Jul 2007 13:54:28 -0000
Received: by lola.quinscape.zz (Postfix, from userid 1001)
	id D8BD68F8F7; Tue,  3 Jul 2007 15:54:28 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0707031437560.4071@racer.site> (Johannes
	Schindelin's message of "Tue\,
	3 Jul 2007 14\:39\:32 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
X-detected-kernel: Linux 2.4-2.6
X-Mailman-Approved-At: Tue, 03 Jul 2007 10:34:43 -0400
X-BeenThere: quilt-dev@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: quilt-dev.nongnu.org
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/quilt-dev>,
	<mailto:quilt-dev-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/quilt-dev>
List-Post: <mailto:quilt-dev@nongnu.org>
List-Help: <mailto:quilt-dev-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/quilt-dev>,
	<mailto:quilt-dev-request@nongnu.org?subject=subscribe>
Sender: quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org
Errors-To: quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51500>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi David,
>
> [please Cc me, since I will be more likely to miss replies if you do not]
>
> On Tue, 3 Jul 2007, David Kastrup wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > But maybe they would be willing to install git to get that wonderful 
>> > git-apply program, and that wonderful rename-and-mode-aware git-diff, 
>> > and the git-merge-file program, all of which can operate outside of a 
>> > git repository. (Take that, hg!)
>> 
>> As long as git-diff lists all added files in a second non-git dirtree
>> as "/dev/null" when doing
>> git-diff --name-status -B -M -C dir1 dir2
>> its usefulness is limited.
>> 
>> git-diff --name-status -B -M -C dir1 dir2
>> D	dir1/auctex-11.84/CHANGES
>> D	dir1/auctex-11.84/COPYING
>> D	dir1/auctex-11.84/ChangeLog
>> 
>> [...]
>
> Yes, directories are a problem. There our DWIMery does not really help. 
> But there is a solution: say
>
> 	git diff --name-status --no-index -B -M -C dir1 dir2

It would help if you actually read what you are replying to.  The
problem is that added files are listed as "/dev/null", and --no-index
does not make a difference here.  It actually makes no apparent
difference at all when outside of a non-git dirtree.  Hardly
surprising, since no index file that could be consulted is present in
the first place.

The output still is (editing somewhat more so that it becomes even
more obvious):

git-diff -B -M -C --no-index --name-status dir1 dir2
D	dir1/auctex-11.84/CHANGES

[...]

A	/dev/null
A	/dev/null
R100	dir1/auctex-11.84/images/amstex.xpm	dir2/etc/auctex/images/amstex.xpm

[...]

_All_ lines starting in A end with /dev/null.

-- 
David Kastrup
