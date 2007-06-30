From: Yann Dirson <ydirson@altern.org>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 21:43:35 +0200
Message-ID: <20070630194335.GK7730@nan92-1-81-57-214-146.fbx.proxad.net>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org> <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 21:43:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4irM-0001TE-U5
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 21:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbXF3Tnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 15:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbXF3Tny
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 15:43:54 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:52986 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbXF3Tny (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 15:43:54 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 616345A19B;
	Sat, 30 Jun 2007 21:43:52 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 6BC591F150; Sat, 30 Jun 2007 21:43:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51247>

On Sat, Jun 30, 2007 at 12:17:10PM -0700, Junio C Hamano wrote:
> So I am somewhat negative on this, unless there is a way for
> scripts to say "Even though I say 'git foo', I do mean 'git foo'
> not whatever the user has aliased".

"git --no-alias foo" (like "cvs -f foo" which ignores ~/.cvsrc) ?

Best regards,
-- 
Yann
