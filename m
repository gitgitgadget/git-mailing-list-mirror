From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Tue, 10 May 2005 00:08:05 +0200
Message-ID: <7iu0lc129m.fsf@lanthane.pps.jussieu.fr>
References: <7ihdhc5le2.fsf@lanthane.pps.jussieu.fr>
	<20050509212842.GC15712@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-devel@abridgegame.org, Git Mailing List <git@vger.kernel.org>
X-From: darcs-devel-bounces@darcs.net Tue May 10 00:01:05 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVGJ8-00052L-0H
	for gcvdd-darcs-devel@m.gmane.org; Tue, 10 May 2005 00:00:58 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DVGQ7-0007qk-1y; Mon, 09 May 2005 18:08:11 -0400
Received: from shiva.jussieu.fr ([134.157.0.129])
	by abridgegame.org with esmtp (Exim 4.50) id 1DVGQ3-0007Mz-Ux
	for darcs-devel@abridgegame.org; Mon, 09 May 2005 18:08:08 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr
	[134.157.168.1])
	by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j49M82rV040084
	; Tue, 10 May 2005 00:08:02 +0200 (CEST)
X-Ids: 165
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr
	[134.157.168.57])
	by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id
	j49M85rs024473 ; Tue, 10 May 2005 00:08:05 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DVGQ1-0007LR-Qn; Tue, 10 May 2005 00:08:05 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050509212842.GC15712@pasky.ji.cz> (Petr Baudis's message of
	"Mon, 9 May 2005 23:28:42 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2
	(shiva.jussieu.fr [134.157.0.165]);
	Tue, 10 May 2005 00:08:02 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 427FDF42.000 by Joe's j-chkmail
	(http://j-chkmail.ensmp.fr)!
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

Ahoj,

> FWIW, Cogito does not lock at all yet - this is one of the things which
> should be fixed soon.

I see.  Let me know if you decide to use a different name for the lock
file so I can switch to using the same one as yours.

                                        Julek
