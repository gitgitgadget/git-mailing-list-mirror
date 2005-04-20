From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 14:54:19 -0700
Organization: OSDL
Message-ID: <20050420145419.6412414f.rddunlap@osdl.org>
References: <20050420205633.GC19112@pasky.ji.cz>
	<20050420211919.GA20129@kroah.com>
	<20050420215117.GJ19112@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: greg@kroah.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 23:51:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DON5U-0003g2-Uh
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 23:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVDTVyo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 17:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVDTVy3
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 17:54:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:7612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261825AbVDTVyX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 17:54:23 -0400
Received: from gargoyle.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	(authenticated bits=0)
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KLsJs3008774
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 14:54:20 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050420215117.GJ19112@pasky.ji.cz>
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

On Wed, 20 Apr 2005 23:51:18 +0200 Petr Baudis wrote:

| Dear diary, on Wed, Apr 20, 2005 at 11:19:19PM CEST, I got a letter
| where Greg KH <greg@kroah.com> told me that...
| > On Wed, Apr 20, 2005 at 10:56:33PM +0200, Petr Baudis wrote:
| > >   The short command version will change from 'git' to 'cg', which should
| > > be shorter to type and free the 'git' command for possible eventual
| > > entry gate for the git commands (so that they are more
| > > namespace-friendly, and it might make most sense anyway if we get fully
| > > libgitized; but this is more of long-term ideas).
| > 
| > Hm, but there already is a 'cg' program out there:
| > 	http://uzix.org/cgvg.html
| > I use it every day :(
| > 
| > How about 'cog' instead?
| 
| Grm. Cg is also name of some scary NVidia thing, and cog is GNOME
| Configurator. CGT are Chimera Grid Tools, but I think we can clash
| with those - at least *I* wouldn't mind. ;-)

I'd rather see you go back to 'tig'...

is there a tig out there?

---
~Randy
