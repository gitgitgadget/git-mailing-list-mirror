From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 08:25:51 -0700
Organization: OSDL
Message-ID: <20050418082551.69a20aeb.rddunlap@osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
	<1113774736.3884.4.camel@localhost.localdomain>
	<Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
	<20050417231959.A30656@flint.arm.linux.org.uk>
	<20050417235136.B30656@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org>
	<20050418150456.GC12750@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, rmk@arm.linux.org.uk, dwmw2@infradead.org,
	git@vger.kernel.org, hpa@zytor.com
X-From: git-owner@vger.kernel.org Mon Apr 18 17:25:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNY6R-0002Ls-Q4
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 17:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVDRP1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 11:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVDRP1h
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 11:27:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:40170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262112AbVDRP0D (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 11:26:03 -0400
Received: from gargoyle.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	(authenticated bits=0)
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3IFPps3032581
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 08:25:52 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050418150456.GC12750@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 18 Apr 2005 08:04:57 -0700 Greg KH wrote:

| On Sun, Apr 17, 2005 at 04:24:24PM -0700, Linus Torvalds wrote:
| > 
| > Tools absolutely matter. And it will take time for us to build up that 
| > kind of helper infrastructure. So being newbie might be part of it, but 
| > it's the smaller part, I say. Rough interfaces is a big issue.
| 
| Speaking of tools, you had a "dotest" program to apply patches in email
| form to a bk tree.  And from what I can gather, you've changed that to
| handle git archives, right?  Any pointers to where I can find this so I
| could try to build up some git trees for you to merge with?  I think I
| can even make a tree with a merge issue if you want to test that out :)

it's at
http://www.kernel.org/pub/linux/kernel/people/torvalds/git-tools.git/

---
~Randy
