From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Tue, 6 May 2008 09:48:05 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805060946510.30431@racer>
References: <86wsm9dbhk.fsf@blue.stonehenge.com> <20080504215208.GG29038@spearce.org> <86skwxd97d.fsf@blue.stonehenge.com> <8663tsbqg0.fsf@blue.stonehenge.com> <alpine.LFD.1.10.0805051049440.32269@woody.linux-foundation.org> <905315640805051200g4c155d15xada4f17e5e2fc424@mail.gmail.com>
 <86fxswa7ra.fsf@blue.stonehenge.com> <alpine.LFD.1.10.0805051240150.32269@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Tarmigan <tarmigan+git@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 06 10:49:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtIr5-00068I-RT
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 10:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227AbYEFIsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 04:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754967AbYEFIsL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 04:48:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:50682 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754637AbYEFIsK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 04:48:10 -0400
Received: (qmail invoked by alias); 06 May 2008 08:48:08 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp027) with SMTP; 06 May 2008 10:48:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oA7R6x1Hoi8StVUU1+7/4oINReGrdzqdAq5Y0Rw
	OtNAiDkwxsJgq2
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LFD.1.10.0805051240150.32269@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81345>

Hi,

On Mon, 5 May 2008, Linus Torvalds wrote:

> We can fix it. Junio hasn't merged my stupid infrastructure into core 
> git yet, and I still don't really care enough or have a OS X box to test 
> on (I've got a couple of mac minis, but they run that other OS ;), but 
> we'll get the insane OS X crap handled *some* day.

FWIW I think you can reproduce on Linux.  AFAIR there is some code in the 
hfs or hfsplus modules to perform the same UTF-8 normalization.

Ciao,
Dscho
