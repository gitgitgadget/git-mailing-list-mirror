From: Gabriel <g2p.code@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Fri, 19 Feb 2010 12:52:18 +0000 (UTC)
Message-ID: <loom.20100219T134421-90@post.gmane.org>
References: <4B7D8358.1080108@gmail.com> <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>  <4B7E3856.3080609@gmail.com> <fabb9a1e1002182349h923d4acv55d9a41a249d4f51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 13:52:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiSLi-0007Wr-Vb
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 13:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab0BSMwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 07:52:45 -0500
Received: from lo.gmane.org ([80.91.229.12]:49147 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285Ab0BSMwo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 07:52:44 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NiSLa-0007Rr-Qj
	for git@vger.kernel.org; Fri, 19 Feb 2010 13:52:42 +0100
Received: from pro75-5-88-162-203-35.fbx.proxad.net ([88.162.203.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 13:52:42 +0100
Received: from g2p.code by pro75-5-88-162-203-35.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 13:52:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 88.162.203.35 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.3a2pre) Gecko/20100217 Minefield/3.7a2pre)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140447>

Sverre Rabbelier writes:
> > I'm still trying to dig up information about how to actually build, test
> > and use a remote helper. I'll probably be reading code for examples.
> 
> Perhaps you could benefit from looking at my git-remote-hg code so
> far, I'll put it up on github [0] today as 'remote-hg'. If you're too
> soon you'll see commit 21215675c as the head, which isn't that useful,
> in that case just look again later :P.
> 
> [0] http://github.com/SRabbelier/git

FWIW, I'm interested in that remote-vcs code, but never figured out where it
was published. TIA for pushing it.
I'll be using it to better integrate fast-import based backup scripts.
