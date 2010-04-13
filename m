From: Dave Abrahams <dave@boostpro.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to &quot;refuse&quot;
Date: Tue, 13 Apr 2010 16:42:45 +0000 (UTC)
Message-ID: <loom.20100413T183858-696@post.gmane.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <alpine.DEB.2.00.0901291729540.22558@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 18:43:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1jCW-00044f-Bp
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 18:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab0DMQmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 12:42:55 -0400
Received: from lo.gmane.org ([80.91.229.12]:53430 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995Ab0DMQmy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 12:42:54 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O1jCO-0003zA-F0
	for git@vger.kernel.org; Tue, 13 Apr 2010 18:42:52 +0200
Received: from 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com ([207.172.223.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 18:42:52 +0200
Received: from dave by 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 18:42:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 207.172.223.249 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-US) AppleWebKit/533.2 (KHTML, like Gecko) Chrome/5.0.342.9 Safari/533.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144822>

Asheesh Laroia <asheesh <at> asheesh.org> writes:


> Being told how to do it right is even better than being told that you're 
> doing it wrong. 

I would prefer if Git would simply "not refuse," but barring that, a more
verbose error would be helpful.  I knew what I was doing in
http://github.com/jelmer/dulwich/issues/issue/17, but it took me a
long time  to even notice git's message.
