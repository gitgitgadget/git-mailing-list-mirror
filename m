From: "Steven E. Harris" <seh@panix.com>
Subject: Re: With feature branches, what is ever committed directly to master
Date: Fri, 13 Aug 2010 18:19:30 -0400
Organization: SEH Labs
Message-ID: <m2ocd6yx3h.fsf@Spindle.sehlabs.com>
References: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
	<AANLkTinwQhD-b0-6uQYwBa3r7psNvPp5LMcjqHVKLF+c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 00:19:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok2bQ-0003XK-Uz
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 00:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab0HMWTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 18:19:47 -0400
Received: from lo.gmane.org ([80.91.229.12]:46257 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755117Ab0HMWTr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 18:19:47 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ok2bD-0003Tv-QX
	for git@vger.kernel.org; Sat, 14 Aug 2010 00:19:39 +0200
Received: from 75-144-0-121-busname-pa.hfc.comcastbusiness.net ([75.144.0.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 00:19:39 +0200
Received: from seh by 75-144-0-121-busname-pa.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 00:19:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 75-144-0-121-busname-pa.hfc.comcastbusiness.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (darwin)
Cancel-Lock: sha1:i06Xmqrn1o34GpqmUqUuOcvQ89s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153520>

Jon Seymour <jon.seymour@gmail.com> writes:

> Otherwise, I keep them clean and merge them into the base of my
> working branch (as described into an earlier note).  By always merging
> into the base of my working branch (and never the tip) I can keep my
> working tree stable and my patches clean.

Can you clarify what you mean by "merging into the base" and "never the
tip"? Perhaps a pointer to the earlier note you mentioned would suffice.

-- 
Steven E. Harris
