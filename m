From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ALSA official git repository
Date: Fri, 27 May 2005 11:16:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 20:13:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbjKB-0002LC-EF
	for gcvg-git@gmane.org; Fri, 27 May 2005 20:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVE0SOv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 14:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVE0SOv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 14:14:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:40895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262043AbVE0SOo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 14:14:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RIEejA026937
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 11:14:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4RIEd4t001443;
	Fri, 27 May 2005 11:14:39 -0700
To: Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 27 May 2005, Jaroslav Kysela wrote:
> 
> Okay, sorry for this small bug. I'll recreate the ALSA git tree with
> proper comments again. Also, the author is not correct (should be taken
> from the first Signed-off-by:).

Hmm.. That's not always true in general, since Sign-off does allow to sign
off on other peoples patches (see the "(b)" clause in DCO), but maybe in
the ALSA tree it is.

Are you coming from a CVS tree or what? It's clearly not my patch 
applicator thing, since that one removes spaces, I'm pretty sure.

		Linus
