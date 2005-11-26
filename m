From: Yann Dirson <ydirson@altern.org>
Subject: Re: git-send-mail in sh
Date: Sun, 27 Nov 2005 00:34:35 +0100
Message-ID: <20051126233434.GL3393@nowhere.earth>
References: <4386DD45.6030308@op5.se> <7v7jaxou5b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 00:33:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eg9X9-0007cj-2O
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 00:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVKZXcj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 18:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVKZXcj
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 18:32:39 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:28054 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750785AbVKZXcj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2005 18:32:39 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 33F164001E;
	Sun, 27 Nov 2005 00:32:38 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1Eg9Yy-0005PK-V6; Sun, 27 Nov 2005 00:34:37 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jaxou5b.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12791>

On Fri, Nov 25, 2005 at 03:15:44AM -0800, Junio C Hamano wrote:
> > function usage() {
> > 	echo "Usage: git submit upstream@email.org <commit-ish> [<commit-ish>]"
> > 	exit 1
> > }
> 
> I'm old fashioned and tend to omit noise word "function".

More importantly, it is not portable.
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
