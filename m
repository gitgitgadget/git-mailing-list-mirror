From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: gitk graph routing problem
Date: Mon, 5 Nov 2007 02:19:07 +0100
Message-ID: <20071105011907.GC5355@steel.home>
References: <20071104104618.GA3078@steel.home> <18222.15870.945694.238217@cargo.ozlabs.ibm.com> <7vzlxtr4bu.fsf@gitster.siamese.dyndns.org> <20071105005349.GA5355@steel.home> <20071105011700.GB5355@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 02:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioqcs-00009m-FL
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 02:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbXKEBTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 20:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754678AbXKEBTL
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 20:19:11 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:39209 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbXKEBTK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 20:19:10 -0500
Received: from tigra.home (Faa53.f.strato-dslnet.de [195.4.170.83])
	by post.webmailer.de (fruni mo56) (RZmta 14.0)
	with ESMTP id 506b23jA4LPcco ; Mon, 5 Nov 2007 02:19:08 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 172B8277AE;
	Mon,  5 Nov 2007 02:19:08 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id D1E5156D22; Mon,  5 Nov 2007 02:19:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071105011700.GB5355@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtoAaXg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63467>

Alex Riesen, Mon, Nov 05, 2007 02:17:00 +0100:
> Alex Riesen, Mon, Nov 05, 2007 01:53:49 +0100:
> > Junio C Hamano, Mon, Nov 05, 2007 00:14:29 +0100:
> > > Paul Mackerras <paulus@samba.org> writes:
> > > 
> > > > Alex Riesen writes:
> > > >
> > > >> To reproduce, try running in git repo:
> > > >> 
> > > >>     gitk 02f630448e5d48e..06ea6ba9cf46ef5
> > > >
> > > > I can't reproduce it here, as my clone of the git repo doesn't have
> > > > 02f630448e5d48e in it, even after updating...
> > > 
> > > Heh, me neither ;-).
> > 
> > Stupid me. Will follow up with a link to the archived repo in private mail.
> > 

and of course, I send it to everyone... Ach, well. Will keep it for a
week, or until it is reproduced somewhere else. Whichever comes first.
