From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: zlib version, list archives
Date: Thu, 21 Apr 2005 10:25:52 -0700
Organization: OSDL
Message-ID: <20050421102552.544c70fd.rddunlap@osdl.org>
References: <4267E0A4.40506@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 19:22:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOfMu-0005gb-4v
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 19:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVDUR0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 13:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVDUR0A
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 13:26:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:54218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261565AbVDURZ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 13:25:56 -0400
Received: from gargoyle.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	(authenticated bits=0)
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3LHPqs3008928
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Apr 2005 10:25:53 -0700
To: jschopp@austin.ibm.com
In-Reply-To: <4267E0A4.40506@austin.ibm.com>
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

On Thu, 21 Apr 2005 12:19:32 -0500 Joel Schopp wrote:

| I downloaded git-pasky 0.6.2.  I cannot compile it because my zlib 
| version is 1.1.4 and git-pasky relies on function deflateBound() which 
| wasn't introduced until zlib version 1.2.x  Is there a patch out there 
| to work around this and maybe conditionally compile based on the zlib 
| version?
| 
| I apologize in advance if this has already been asked, I cannot find an 
| archive of this list.  Could somebody point me to one?

http://marc.theaimsgroup.com/?l=git
or
http://dir.gmane.org/gmane.comp.version-control.git

---
~Randy
