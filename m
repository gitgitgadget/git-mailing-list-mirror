From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] debian/ directory
Date: Sat, 7 Jan 2006 12:19:48 +0100
Message-ID: <20060107111948.GC32585@nowhere.earth>
References: <7v64pbc4fh.fsf@assigned-by-dhcp.cox.net> <20051228112018.19646.qmail@c226d15586b0bf.315fe32.mid.smarden.org> <87oe31urge.kvalo.fsf@purkki.valo.iki.fi> <20060102103138.3414.qmail@e631ec7a6a8b9a.315fe32.mid.smarden.org> <7vzmm9rnj7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 12:17:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvC4k-000337-6G
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 12:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWAGLRX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 06:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWAGLRW
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 06:17:22 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:60888 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030409AbWAGLRW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 06:17:22 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D22A843FFF;
	Sat,  7 Jan 2006 12:17:12 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EvC6v-00033V-1j; Sat, 07 Jan 2006 12:19:49 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmm9rnj7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14258>

On Fri, Jan 06, 2006 at 02:37:16PM -0800, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> 
> > Thanks to Norbert Tretkowski, the git* and cogito packages are now
> > available for Debian sarge through http://backports.org/.
> 
> Good to hear.  Does that mean nobody would suffer if I drop
> debian/ subdirectory along with deb target in the main Makefile
> anymore?  If so I would.

Well, it's probably still a quick way to produce snapshot packages
when needed.  An alternative could be to have Norbert's tree
accessible, and possibly advertized in the docs, so a simple merge
would be sufficient to build a snapshot package.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
