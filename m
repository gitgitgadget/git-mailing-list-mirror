From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC PATCH] detection of directory renames
Date: Mon, 27 Oct 2008 20:13:16 +0100
Message-ID: <20081027191316.GC5158@nan92-1-81-57-214-146.fbx.proxad.net>
References: <7vfxojtr9t.fsf@gitster.siamese.dyndns.org> <20080925213819.27029.47944.stgit@gandelf.nowhere.earth> <m3fxmignz3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 20:14:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuXY0-0003L1-S9
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 20:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbYJ0TN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 15:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbYJ0TN0
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 15:13:26 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:42185 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbYJ0TN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 15:13:26 -0400
Received: from smtp5-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp5-g19.free.fr (Postfix) with ESMTP id A05573EB25B;
	Mon, 27 Oct 2008 20:13:23 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 864853EB24E;
	Mon, 27 Oct 2008 20:13:23 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id A27E11F0C2; Mon, 27 Oct 2008 20:13:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3fxmignz3.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99250>

On Mon, Oct 27, 2008 at 06:35:44AM -0700, Jakub Narebski wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > This is a first very preliminar patch, mostly so people can comment
> > early on the big picture.  It has a number of limitations, many but
> > not all already listed as FIXME's in the patch itself.  If anything in
> > this patch seems so wrong it is not worth polishing it, it's the
> > perfect time to say so :)
> 
> What happened to this work? I din't see it mentioned in "what's
> cooking..." announcements...

I'm slowly bugfixing it, and plan to post a slightly updated version
soon.
