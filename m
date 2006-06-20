From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.17-rc6-mm2
Date: Mon, 19 Jun 2006 20:22:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606192016210.5498@g5.osdl.org>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com> 
 <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com> 
 <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org>
 <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com>
 <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org> <44976506.8040205@logix.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Goo GGooo <googgooo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 20 05:23:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsWpU-0004N2-BH
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 05:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965440AbWFTDXA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 23:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965439AbWFTDXA
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 23:23:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40877 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965428AbWFTDW7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 23:22:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5K3Mkgt031486
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Jun 2006 20:22:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5K3MdNm025580;
	Mon, 19 Jun 2006 20:22:42 -0700
To: Michal Ludvig <michal@logix.cz>
In-Reply-To: <44976506.8040205@logix.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22161>



On Tue, 20 Jun 2006, Michal Ludvig wrote:
> 
> OpenBSD has CVS access to their repos over SSH even for anonymous users.
> Could something similar be set up on git.kernel.org as well?

I suspect the kernel.org people would prefer not to. And I'm almost 
certain that others don't want to. It would really be much better if the 
git protocol itself just had a sideband channel. Oh, well.

			Linus
