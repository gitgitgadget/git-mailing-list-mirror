From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rsync update appears broken now
Date: Thu, 20 Oct 2005 17:52:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510201752050.10477@g5.osdl.org>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
 <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
 <Pine.LNX.4.64.0510201038320.3369@g5.osdl.org> <loom.20051020T220751-355@post.gmane.org>
 <Pine.LNX.4.64.0510201432260.10477@g5.osdl.org> <7vek6f220h.fsf@arte.twinsun.com>
 <Pine.LNX.4.64.0510201645450.10477@g5.osdl.org> <loom.20051021T022509-63@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 02:53:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESl9B-0002KI-O7
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 02:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVJUAwf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 20:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVJUAwf
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 20:52:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964835AbVJUAwd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 20:52:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9L0qUFC004608
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 17:52:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9L0qTnO017528;
	Thu, 20 Oct 2005 17:52:30 -0700
To: Junio C Hamano <junkio@twinsun.com>
In-Reply-To: <loom.20051021T022509-63@post.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10401>



On Fri, 21 Oct 2005, Junio C Hamano wrote:
> 
> I am reasonably sure that the screw-up was only rewinding one commit too much.
> I've done the merge so things should look better once mirrors catch up.

Yup, works at least for me. Thx,

		Linus
