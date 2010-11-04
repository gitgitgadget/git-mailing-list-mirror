From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: can subversion 1.6 be made "just as distributed as git"?
Date: Thu, 04 Nov 2010 09:44:01 +0100
Message-ID: <vpqy699xyum.fsf@bauges.imag.fr>
References: <loom.20101104T014408-903@post.gmane.org>
	<BF8EE51A-AFE4-4EBA-82E8-4A8B32678FBF@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: MDellerus <mdellerus@yahoo.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 09:48:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDvUG-0004E2-Rc
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 09:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320Ab0KDIrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 04:47:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38777 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092Ab0KDIoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 04:44:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oA48Svgb011715
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Nov 2010 09:28:57 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PDvQP-0007oF-SC; Thu, 04 Nov 2010 09:44:01 +0100
In-Reply-To: <BF8EE51A-AFE4-4EBA-82E8-4A8B32678FBF@sb.org> (Kevin Ballard's message of "Wed\, 3 Nov 2010 17\:58\:29 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 04 Nov 2010 09:28:57 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA48Svgb011715
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289464139.13698@l2/3QkMeFQY5BCQzhF9Lgg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160695>

Kevin Ballard <kevin@sb.org> writes:

> Using "svnadmin hotcopy" you could certainly get your own local repo, but I fail to
> see how you could easily join your history up with someone else's history using this
> mechanism. If you really want to use SVN in a distributed manner, I would recommend
> you simply use SVK.

Right. Branching is the easy part. Merging is the hard and important
one.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
