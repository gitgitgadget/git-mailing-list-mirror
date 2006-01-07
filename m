From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] debian/ directory
Date: Sat, 07 Jan 2006 14:05:17 -0800
Message-ID: <7vace7elsy.fsf@assigned-by-dhcp.cox.net>
References: <7v64pbc4fh.fsf@assigned-by-dhcp.cox.net>
	<20051228112018.19646.qmail@c226d15586b0bf.315fe32.mid.smarden.org>
	<87oe31urge.kvalo.fsf@purkki.valo.iki.fi>
	<20060102103138.3414.qmail@e631ec7a6a8b9a.315fe32.mid.smarden.org>
	<7vzmm9rnj7.fsf@assigned-by-dhcp.cox.net>
	<20060107111948.GC32585@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 23:05:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvMBm-0003sq-Mz
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 23:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030610AbWAGWFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 17:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030612AbWAGWFV
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 17:05:21 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:18898 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030611AbWAGWFT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 17:05:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107220309.HYYS17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 17:03:09 -0500
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060107111948.GC32585@nowhere.earth> (Yann Dirson's message of
	"Sat, 7 Jan 2006 12:19:48 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14279>

Yann Dirson <ydirson@altern.org> writes:

> Well, it's probably still a quick way to produce snapshot packages
> when needed.  An alternative could be to have Norbert's tree
> accessible, and possibly advertized in the docs, so a simple merge
> would be sufficient to build a snapshot package.

I took a brief look at backports.org and git-core_$V.diff there.
It is my understanding that Norbert's tree is essentially a copy
of Gerrit's, with inevitable differences in debian/changelog.
If we _were_ to replace it with something else, I'd rather get
patches fed from Gerrit.
