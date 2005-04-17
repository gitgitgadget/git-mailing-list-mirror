From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: SHA1 hash safety
Date: Sun, 17 Apr 2005 02:35:00 -0400
Message-ID: <200504170635.j3H6Z0Ga005661@laptop11.inf.utfsm.cl>
References: <20050416154951.GB13373@jose.lug.udel.edu>
Cc: "C. Scott Ananian" <cscott@cscott.net>, omb@bluewin.ch,
	David Lang <david.lang@digitalinsight.com>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 03:10:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKlv-0004Bd-Uw
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVDRBNa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 21:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVDRBN3
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 21:13:29 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57792 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261437AbVDRBNT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 21:13:19 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j3H6Z3sA005664;
	Sun, 17 Apr 2005 02:35:03 -0400
Received: from laptop11.inf.utfsm.cl (vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.4/8.13.4/Submit) with ESMTP id j3H6Z0Ga005661;
	Sun, 17 Apr 2005 02:35:01 -0400
To: ross@jose.lug.udel.edu
In-Reply-To: Message from ross@jose.lug.udel.edu 
   of "Sat, 16 Apr 2005 11:49:51 -0400." <20050416154951.GB13373@jose.lug.udel.edu> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

ross@jose.lug.udel.edu said:

[...]

> Linus has already weighed in that he doesn't give a crap.  All the
> crypto-babble about collision whitepapers is uninteresting without a
> repo that has real collisions.  git is far too cool as is - prove I
> should be concerned.

Just copy over a file (might be the first step in splitting it, or a
header file that is duplicated for convenience, ...)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
