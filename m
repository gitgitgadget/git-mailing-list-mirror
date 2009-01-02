From: "Philippe Bruhat (BooK)" <philippe.bruhat@free.fr>
Subject: Re: [PATCH] Git.pm: let a false Directory parameter (such as 0) be
	used correctly by the constructor
Date: Fri, 2 Jan 2009 10:09:40 +0100
Message-ID: <20090102090940.GA23222@plop>
References: <1230886057-23994-1-git-send-email-book@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 10:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIg3i-0000fo-5R
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 10:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663AbZABJJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 04:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbZABJJv
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 04:09:51 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:58012 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbZABJJu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 04:09:50 -0500
Received: from localhost ([127.0.0.1] helo=plop)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1LIfxp-00070W-Th; Fri, 02 Jan 2009 10:05:06 +0100
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1LIg2G-0006mZ-Qo; Fri, 02 Jan 2009 10:09:40 +0100
Content-Disposition: inline
In-Reply-To: <1230886057-23994-1-git-send-email-book@cpan.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104368>

On Fri, Jan 02, 2009 at 09:47:37AM +0100, Philippe Bruhat (BooK) wrote:
> Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
> ---
>  perl/Git.pm |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

Please ignore, I forgot half of the the requested changes. Sorry for the
noise.

-- 
 Philippe Bruhat (BooK)

 Mankind is the story of the same mistakes in different places.
                                                 (Moral from Groo #1 (Image))
