From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-fast-import
Date: Thu, 8 Feb 2007 08:56:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702080851140.8424@woody.linux-foundation.org>
References: <20070206023111.GB9222@spearce.org> <45C81C33.6010704@gmail.com>
 <20070206061817.GB10508@spearce.org> <Pine.LNX.4.64.0702062347060.20138@iabervon.org>
 <20070207091351.GA1632@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0702071216330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070207225532.GA1970@spearce.org> <Pine.LNX.4.63.0702080054180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 17:56:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFCZR-0007JB-Ni
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 17:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423081AbXBHQ40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 11:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423231AbXBHQ40
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 11:56:26 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49650 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423081AbXBHQ40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 11:56:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l18GuAdD023746
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Feb 2007 08:56:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l18Gu8gB019461;
	Thu, 8 Feb 2007 08:56:08 -0800
In-Reply-To: <Pine.LNX.4.63.0702080054180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.439 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.113__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39062>



On Thu, 8 Feb 2007, Johannes Schindelin wrote:
> 
> Ah! I overlooked that feature. Certainly, this makes gfi (could we please 
> call it "fast-import", please?) very useful for history rewriting 
> purposed.

Yeah, I think fast-import is great. And I'd also like to echo that call to 
not call it "gfi". Maybe it's just me, and maybe it's just because I'm a 
home-owner who does things like add in-wall ethernet cables, but to me, 
gfi is about an electrical outlet.

So to me, gfi means "ground fault interrupter": the kind of outlet that 
breaks the circuit if there is current leaking to the ground pin. All your 
electrical outlets in "wet areas" (bathroom, kitchen within a certain 
distance of a sink, outside, near swimming pools etc) are supposed to be 
GFI's.

I realize that there's not a lot of chance of confusion in the git world, 
but still.

			Linus
