From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 13:20:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605221312380.3697@g5.osdl.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> 
 <446F95A2.6040909@gentoo.org>  <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org>
  <446FA262.7080900@gentoo.org>  <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
  <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>  <44713BE4.9040505@gentoo.org>
  <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org> 
 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> 
 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
 <44720C66.6040304@gentoo.org> <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>
 <447215D4.5020403@gentoo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 22:21:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiGuO-00065i-Pz
	for gcvg-git@gmane.org; Mon, 22 May 2006 22:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWEVUV3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 16:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWEVUV3
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 16:21:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62657 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751170AbWEVUV2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 16:21:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4MKKUtH027036
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 May 2006 13:20:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4MKKT7S012200;
	Mon, 22 May 2006 13:20:30 -0700
To: Donnie Berkholz <spyderous@gentoo.org>
In-Reply-To: <447215D4.5020403@gentoo.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20531>



On Mon, 22 May 2006, Donnie Berkholz wrote:
>
> Linus Torvalds wrote:
> > Hmm. My cvs server doesn't really grow at all. It's at 13M RSS.
> 
> Yeah, that's the thing. RSS stayed about the same (according to top),
> but virtual just kept growing.

Not for me. The virtual size is certainly bigger than RSS, but not by a 
huge amount. So this might be a regression in CVS, since you seem to have 
a newer version than I do.

The latest stable CVS release is 1.11.21, I think: you seem to be running 
the "development" version (1.12.x).

			Linus
