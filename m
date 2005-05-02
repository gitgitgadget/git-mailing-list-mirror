From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Quick command reference
Date: Sun, 1 May 2005 17:09:17 -0700
Organization: OSDL
Message-ID: <20050501170917.4a8f3756.rddunlap@osdl.org>
References: <17012.53862.704670.858276@cargo.ozlabs.ibm.com>
	<4274EB3D.2060602@dgreaves.com>
	<4274F373.6030001@khandalf.com>
	<4274FB3F.8090206@dgreaves.com>
	<Pine.LNX.4.58.0505010927040.2296@ppc970.osdl.org>
	<20050501211808.GA6900@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, david@dgreaves.com, omb@bluewin.ch,
	paulus@samba.org, git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Mon May 02 02:04:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSOQZ-00082S-Eg
	for gcvg-git@gmane.org; Mon, 02 May 2005 02:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVEBAKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 20:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVEBAKb
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 20:10:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:26848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261524AbVEBAJ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 20:09:58 -0400
Received: from midway.verizon.net (wbar2.sea1-4-5-049-023.sea1.dsl-verizon.net [4.5.49.23])
	(authenticated bits=0)
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4209Ms3009726
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 May 2005 17:09:24 -0700
To: bert hubert <ahu@ds9a.nl>
In-Reply-To: <20050501211808.GA6900@outpost.ds9a.nl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 1 May 2005 23:18:08 +0200 bert hubert wrote:

| On Sun, May 01, 2005 at 09:29:23AM -0700, Linus Torvalds wrote:
| > (And no, by "standard format" I do _not_ mean xml or stuff like that. I 
| > mean something that is actually easy to read ;)
| 
| I've recently been very happy with AsciiDoc
| http://www.methods.co.nz/asciidoc/ - it's input is as easy to read as to
| write.
| 
| >From this input:
| http://ds9a.nl/splitpipe/splitpipe-0.3/doc/splitpipe.1.txt
| 
| It produces this lovely page (html, man, pdf, the works):
| http://ds9a.nl/splitpipe/splitpipe-0.3/doc/splitpipe.1.html
| 
| And if you are really in a wild mood, you can have it make entire websites,
| like http://ds9a.nl/splitpipe
| 
| When used properly it builds tables of contents, indexes, books and whatnot.

AsciiDoc is already agreed upon, but here's another one that
I have used:  Markdown:
  http://daringfireball.net/projects/markdown/

---
~Randy
