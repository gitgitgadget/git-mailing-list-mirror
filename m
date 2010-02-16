From: Michal Sojka <sojkam1-jQs2MHkdoM/twjQa/ONI9g@public.gmane.org>
Subject: Re: Using test-lib.sh under GPLv3?
Date: Tue, 16 Feb 2010 14:06:02 +0100
Message-ID: <87r5olfhz9.fsf@steelpick.localdomain>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
	<87hbpwpoko.fsf@yoom.home.cworth.org>
	<5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com>
	<201002081614.24284.sojkam1@fel.cvut.cz>
	<871vgr78lr.fsf@yoom.home.cworth.org>
	<87iqa2y0gz.fsf@steelpick.localdomain>
	<87r5oqe7mi.fsf@yoom.home.cworth.org>
	<871vgmki4f.fsf@steelpick.localdomain>
	<m3aav98oj7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Jakub Narebski <jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org Tue Feb 16 14:06:19 2010
Return-path: <notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>
Envelope-to: gmn-notmuch@m.gmane.org
Received: from u15218177.onlinehome-server.com ([82.165.184.25] helo=olra.theworths.org)
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>)
	id 1NhN86-0001Rg-MK
	for gmn-notmuch@m.gmane.org; Tue, 16 Feb 2010 14:06:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id F251D431FC0;
	Tue, 16 Feb 2010 05:06:15 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JMQ7S9IjU5nM; Tue, 16 Feb 2010 05:06:13 -0800 (PST)
Received: from olra.theworths.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 79864431FBD;
	Tue, 16 Feb 2010 05:06:13 -0800 (PST)
X-Original-To: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Delivered-To: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 6084F431FBF
	for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>; Tue, 16 Feb 2010 05:06:12 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PuqxgzR8DBDk for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>;
	Tue, 16 Feb 2010 05:06:11 -0800 (PST)
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
	by olra.theworths.org (Postfix) with ESMTP id 598A1431FAE
	for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>; Tue, 16 Feb 2010 05:06:11 -0800 (PST)
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 98FB219F33D8;
	Tue, 16 Feb 2010 14:06:10 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new,
	port 10044)
	with ESMTP id 9ppb7-KB9n6V; Tue, 16 Feb 2010 14:06:06 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 06D6C19F33CD;
	Tue, 16 Feb 2010 14:06:05 +0100 (CET)
Received: from steelpick.localdomain (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 42F61FA003;
	Tue, 16 Feb 2010 14:06:02 +0100 (CET)
Received: from wsh by steelpick.localdomain with local (Exim 4.71)
	(envelope-from <sojkam1-jQs2MHkdoM/twjQa/ONI9g@public.gmane.org>)
	id 1NhN7q-00058X-4C; Tue, 16 Feb 2010 14:06:02 +0100
In-Reply-To: <m3aav98oj7.fsf-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
X-BeenThere: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: "Use and development of the notmuch mail system."
	<notmuch.notmuchmail.org>
List-Unsubscribe: <http://notmuchmail.org/mailman/options/notmuch>,
	<mailto:notmuch-request-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://notmuchmail.org/pipermail/notmuch>
List-Post: <mailto:notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>
List-Help: <mailto:notmuch-request-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org?subject=help>
List-Subscribe: <http://notmuchmail.org/mailman/listinfo/notmuch>,
	<mailto:notmuch-request-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org?subject=subscribe>
Sender: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Errors-To: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140100>

On Tue, 16 Feb 2010 02:27:37 -0800 (PST), Jakub Narebski <jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Michal Sojka <sojkam1-jQs2MHkdoM/twjQa/ONI9g@public.gmane.org> writes:
> 
> > I like the simple and powerful test suite used by Git and I would like
> > to use something like that in Notmuch project (http://notmuchmail.org/).
> > [...]
>
> Have you thought about using TAP (Test Anything Protocol) format for
> your testsuite?  Its page (http://testanything.org) has a TAP-producing
> bash library: http://testanything.org/wiki/index.php/Tap-functions

Yes, somebody has mentiond TAP on notmuch list. From a quick look at TAP
shell library it seems to me a bit more complex then git's library and
it also requires bash.

If we need to use some TAP-based tools, we could easily change the
output of git's library to conform to TAP. Right?

Michal
