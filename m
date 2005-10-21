From: Junio C Hamano <junkio@twinsun.com>
Subject: Re: rsync update appears broken now
Date: Fri, 21 Oct 2005 00:26:52 +0000 (UTC)
Message-ID: <loom.20051021T022509-63@post.gmane.org>
References: <86vezs9wy9.fsf@blue.stonehenge.com> <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com> <Pine.LNX.4.64.0510201038320.3369@g5.osdl.org> <loom.20051020T220751-355@post.gmane.org> <Pine.LNX.4.64.0510201432260.10477@g5.osdl.org> <7vek6f220h.fsf@arte.twinsun.com> <Pine.LNX.4.64.0510201645450.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 21 02:31:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESkmu-0003lu-33
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 02:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVJUA3e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 20:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVJUA3d
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 20:29:33 -0400
Received: from main.gmane.org ([80.91.229.2]:12254 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964818AbVJUA3d (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 20:29:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ESklW-0003Tr-DH
	for git@vger.kernel.org; Fri, 21 Oct 2005 02:28:10 +0200
Received: from ip-66-80-53-59.lax.megapath.net ([66.80.53.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Oct 2005 02:28:10 +0200
Received: from junkio by ip-66-80-53-59.lax.megapath.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Oct 2005 02:28:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.80.53.59 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10396>

Linus Torvalds <torvalds <at> osdl.org> writes:

> The latest one I have is ea5a65a59916503d2a14369c46b1023384d51645, but if 
> you had more pushed out at some point that I just didn't happen to pick 
> up, that may not be the top-most (A).

I am reasonably sure that the screw-up was only rewinding one commit too much.
I've done the merge so things should look better once mirrors catch up.

Thanks for your help.
