From: Michal Sojka <sojkam1-jQs2MHkdoM/twjQa/ONI9g@public.gmane.org>
Subject: Re: Using test-lib.sh under GPLv3?
Date: Fri, 19 Feb 2010 09:19:00 +0100
Message-ID: <87tytdiqob.fsf@steelpick.localdomain>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
	<87hbpwpoko.fsf@yoom.home.cworth.org>
	<5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com>
	<201002081614.24284.sojkam1@fel.cvut.cz>
	<871vgr78lr.fsf@yoom.home.cworth.org>
	<87iqa2y0gz.fsf@steelpick.localdomain>
	<87r5oqe7mi.fsf@yoom.home.cworth.org>
	<871vgmki4f.fsf@steelpick.localdomain>
	<7vaav8hpfo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pierre Habouzit <madcoder-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>,
	Johannes Schindelin <johannes.schindelin-Mmb7MZpHnFY@public.gmane.org>,
	Johannes Sixt <j6t-FFprn4rPSa4@public.gmane.org>, Sverre Rabbelier <srabbelier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org Fri Feb 19 09:19:16 2010
Return-path: <notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>
Envelope-to: gmn-notmuch@m.gmane.org
Received: from u15218177.onlinehome-server.com ([82.165.184.25] helo=olra.theworths.org)
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>)
	id 1NiO4w-0007ZO-S1
	for gmn-notmuch@m.gmane.org; Fri, 19 Feb 2010 09:19:15 +0100
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 5FF23431FC3;
	Fri, 19 Feb 2010 00:19:13 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LFbn3u+SG56z; Fri, 19 Feb 2010 00:19:11 -0800 (PST)
Received: from olra.theworths.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 02642431FBD;
	Fri, 19 Feb 2010 00:19:11 -0800 (PST)
X-Original-To: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Delivered-To: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 0BC9B431FAE
	for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>; Fri, 19 Feb 2010 00:19:09 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9uNZd1TJTMnj for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>;
	Fri, 19 Feb 2010 00:19:07 -0800 (PST)
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
	by olra.theworths.org (Postfix) with ESMTP id BCE88431FBC
	for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>; Fri, 19 Feb 2010 00:19:07 -0800 (PST)
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 4346D19F33F9;
	Fri, 19 Feb 2010 09:19:06 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new,
	port 10044)
	with ESMTP id rxBYISJugzks; Fri, 19 Feb 2010 09:19:02 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id D009B19F33F6;
	Fri, 19 Feb 2010 09:19:01 +0100 (CET)
Received: from steelpick.localdomain (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 4500BFA004;
	Fri, 19 Feb 2010 09:19:01 +0100 (CET)
Received: from wsh by steelpick.localdomain with local (Exim 4.71)
	(envelope-from <sojkam1-jQs2MHkdoM/twjQa/ONI9g@public.gmane.org>)
	id 1NiO4i-0007GH-Nf; Fri, 19 Feb 2010 09:19:00 +0100
In-Reply-To: <7vaav8hpfo.fsf-s2KvWo2KEQL18tm6hw+yZpy9Z0UEorGK@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140432>

Dear Pierre, Johannes (2x) and Sverre,

as you can read bellow, I'd like to use git's test-lib.sh in a GPLv3
project. Do you mind if I use your work in that file under GPLv3?

Thanks
Michal

On Mon, 15 Feb 2010 09:39:28 +0100, Michal Sojka <sojkam1-jQs2MHkdoM/twjQa/ONI9g@public.gmane.org> wrote:
> Dear Junio,
> 
> I like the simple and powerful test suite used by Git and I would like
> to use something like that in Notmuch project (http://notmuchmail.org/).
> Notmuch is licenced under GPLv3 and we think that things will be simpler
> if everything in the repository is licenced the same. You are mentioned
> as a copyright holder in test-lib.sh and t0000-basic.sh so I'd like to
> ask you: Would you mind using parts of these files under GPLv3?
> 
> You can see the patches for how I'd like to use these files at
> http://notmuchmail.org/pipermail/notmuch/2010/thread.html#1431

On Tue, 16 Feb 2010 12:54:19 -0800, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org> wrote:
> I don't mind for the parts I wrote, which is the basic infrastructure
> (output redirection, skipping certain tests, expecting failure, etc).
> My blessing would be enough to relicense it if you are are going to take
> the file from some old version like 04ece59 (GIT_SKIP_TESTS: allow users
> to omit tests that are known to break, 2006-12-28) and base your work on
> it, but otherwise it would not be nearly sufficient.
> 
> Other people worked on polishing it over time and they all hold copyright
> on their parts.  Notable parts that are not mine and that are not git
> specific are:
> 
>  - color output support is mostly by Pierre Habouzit <madcoder-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
>  - valgrind support: Johannes Schindelin <johannes.schindelin-Mmb7MZpHnFY@public.gmane.org>
>  - conditional test: Johannes Sixt <j6t-FFprn4rPSa4@public.gmane.org>
>  - summarizing the results: Sverre Rabbelier <srabbelier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
