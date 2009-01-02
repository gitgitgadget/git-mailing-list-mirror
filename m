From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: Re: [PATCH] Git.pm: let a "false" Directory parameter (such as
	"0") be used correctly by the constructor"
Date: Fri, 2 Jan 2009 09:37:34 +0100
Message-ID: <20090102083734.GB25518@plop>
References: <1230510300-7854-1-git-send-email-book@cpan.org> <7vwsdeivx9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 09:39:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIfYh-0003pO-9N
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 09:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbZABIhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 03:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbZABIhq
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 03:37:46 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:45008 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbZABIhp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 03:37:45 -0500
Received: from localhost ([127.0.0.1] helo=plop)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1LIfSl-0006hj-Va; Fri, 02 Jan 2009 09:33:00 +0100
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1LIfXC-000628-RZ; Fri, 02 Jan 2009 09:37:34 +0100
Content-Disposition: inline
In-Reply-To: <7vwsdeivx9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104365>

On Thu, Jan 01, 2009 at 01:00:18PM -0800, Junio C Hamano wrote:
> "Philippe Bruhat (BooK)" <book@cpan.org> writes:
> 
> > ---
> >  perl/Git.pm |    7 ++++---
> >  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> Lacks sign-off and description but otherwise looks good.  Will queue to
> 'pu' to leave you a chance to re-send.

Yeah, I noticed the lack of Sign-off right after sending. I'll re-send.

-- 
 Philippe Bruhat (BooK)

 A reputation is only as good as the truth beneath it, if any.
                                    (Moral from Groo The Wanderer #91 (Epic))
