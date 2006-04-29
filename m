From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Two gitweb feature requests
Date: Sat, 29 Apr 2006 13:16:26 +0200
Organization: At home
Message-ID: <e2v46t$gu9$1@sea.gmane.org>
References: <1146144425.11909.450.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Apr 29 13:16:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZnQg-00013q-4c
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 13:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWD2LPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 07:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbWD2LPx
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 07:15:53 -0400
Received: from main.gmane.org ([80.91.229.2]:9627 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750703AbWD2LPw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 07:15:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FZnQR-00012N-Vx
	for git@vger.kernel.org; Sat, 29 Apr 2006 13:15:48 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Apr 2006 13:15:47 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Apr 2006 13:15:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19300>

It would be nice if gitweb provided for the GIT repository description which
doesn't fit the "Description" column and is shortened, and any other text
which doesn't fit it's own column, full text of said field as the "title"
attribute for the cell 'td' element, or encompasing 'span' element. It
would result in having full, not shortened text of said field (e.g.
repository description) in the pop-up on mouse hover over said field. To
simplify things it could be provided unconditionally, regardless whether
the field needs shortening or not.

By the way, would it be possible for the repository without provided
description to stand out more, perhaps by changing formatting of default
description: 
  "Unnamed repository; edit this file to name it for gitweb."
to use ALL CAPS for attention, like that: 
  "UNNAMED REPOSITORY; edit this file to name it for gitweb."
or perhaps if possible use HTML formatting [additionally] for that.

-- 
Jakub Narebski
Warsaw, Poland
