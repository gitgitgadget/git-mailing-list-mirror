From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: gitk graph routing problem
Date: Mon, 5 Nov 2007 01:53:49 +0100
Message-ID: <20071105005349.GA5355@steel.home>
References: <20071104104618.GA3078@steel.home> <18222.15870.945694.238217@cargo.ozlabs.ibm.com> <7vzlxtr4bu.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 01:54:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoqEK-0003ma-St
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 01:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbXKEAx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 19:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbXKEAx6
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 19:53:58 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:32486 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbXKEAx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 19:53:58 -0500
Received: from tigra.home (Faa53.f.strato-dslnet.de [195.4.170.83])
	by post.webmailer.de (klopstock mo42) (RZmta 14.0)
	with ESMTP id J03989jA4LxCta ; Mon, 5 Nov 2007 01:53:52 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4509B277AE;
	Mon,  5 Nov 2007 01:53:50 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id B843F56D22; Mon,  5 Nov 2007 01:53:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vzlxtr4bu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtoAaXg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63464>

Junio C Hamano, Mon, Nov 05, 2007 00:14:29 +0100:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > Alex Riesen writes:
> >
> >> To reproduce, try running in git repo:
> >> 
> >>     gitk 02f630448e5d48e..06ea6ba9cf46ef5
> >
> > I can't reproduce it here, as my clone of the git repo doesn't have
> > 02f630448e5d48e in it, even after updating...
> 
> Heh, me neither ;-).

Stupid me. Will follow up with a link to the archived repo in private mail.
