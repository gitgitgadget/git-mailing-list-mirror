From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A darcs that can pull from git
Date: Mon, 25 Apr 2005 17:55:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251752570.18901@ppc970.osdl.org>
References: <7ipswjbybx.fsf@lanthane.pps.jussieu.fr>
	<20050425133116.GG11667@abridgegame.org>
	<7i4qdusxdw.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Tue Apr 26 02:48:58 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQEFm-0003Z4-6B
	for gcvdd-darcs-devel@m.gmane.org; Tue, 26 Apr 2005 02:48:42 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DQEKS-000652-Jz; Mon, 25 Apr 2005 20:53:32 -0400
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by abridgegame.org with esmtp (Exim 4.50) id 1DQEKN-00064q-F3
	for darcs-devel@darcs.net; Mon, 25 Apr 2005 20:53:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3Q0rNs4019193
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 17:53:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3Q0rMMV017885;
	Mon, 25 Apr 2005 17:53:23 -0700
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
In-Reply-To: <7i4qdusxdw.fsf@lanthane.pps.jussieu.fr>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
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


[ Side note: I tend to read the mailing lists much less often, and more 
  likely to skip stuff, so if you have a question that is literally for me 
  personally, it's probably best to Cc my private address rather than 
  depending on me reading every single mailing list email ]

On Mon, 25 Apr 2005, Juliusz Chroboczek wrote:
> 
> Linus, could you please suggest a suitable license statement to
> include in whichever files of yours we choose to include in Darcs?  Is
> David's suggestion (stock GPL boilerplate with ``or any later
> version'' removed) okay with you?

Stock GNU boilerplate without the "or any later version" works fine. 

As does a simple one-liner "Licensed under GPLv2", for that matter. It's 
not like there can be any real confusion.

		Linus
