From: "Steven E. Harris" <seh@panix.com>
Subject: Re: How does git follow branch history across a merge commit?
Date: Sat, 29 Aug 2009 20:29:57 -0400
Organization: SEH Labs
Message-ID: <83ws4m3zzu.fsf@torus.sehlabs.com>
References: <8363c75zug.fsf@torus.sehlabs.com>
	<7vskfbcy9n.fsf@alter.siamese.dyndns.org>
	<7vmy5jbjkr.fsf@alter.siamese.dyndns.org>
	<831vmv5wh7.fsf@torus.sehlabs.com>
	<7vy6p38p4j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 30 02:31:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhYKk-0003gU-Hz
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 02:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbZH3AaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 20:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752792AbZH3AaT
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 20:30:19 -0400
Received: from lo.gmane.org ([80.91.229.12]:34578 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579AbZH3AaT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 20:30:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MhYJH-0003Rq-ML
	for git@vger.kernel.org; Sun, 30 Aug 2009 02:30:19 +0200
Received: from c-24-23-120-65.hsd1.pa.comcast.net ([24.23.120.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 02:30:19 +0200
Received: from seh by c-24-23-120-65.hsd1.pa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 02:30:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-23-120-65.hsd1.pa.comcast.net
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (windows-nt)
Cancel-Lock: sha1:O0VQSI3ecsilESmXujfVK39NENU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127387>

Junio C Hamano <gitster@pobox.com> writes:

> *1* If you do not know what a merge simplification is, refer to e.g.
> http://gitster.livejournal.com/35628.html and notice there is a place
> where we follow "a parent that is the same as the merge result".

I read this article today with great interest. Had I known of it
beforehand, it would have changed some of my flawed assumptions evident
in my post. Thanks for writing that. I'll be looking into the rest of
the articles there to learn more.

-- 
Steven E. Harris
