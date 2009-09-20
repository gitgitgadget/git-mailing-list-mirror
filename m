From: tom fogal <tfogal@alumni.unh.edu>
Subject: Re: [PATCH] Remove '< >' from [<options>] since it's not necessary.
Date: Sun, 20 Sep 2009 15:12:44 -0600
Message-ID: <auto-000020523897@sci.utah.edu>
References: <1253476116-24284-1-git-send-email-tfransosi@gmail.com>  <auto-000020523806@sci.utah.edu>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 23:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpTfM-0003Dv-5l
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 23:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbZITVJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 17:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbZITVJm
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 17:09:42 -0400
Received: from mail.sci.utah.edu ([155.98.58.79]:51714 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751106AbZITVJm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 17:09:42 -0400
Received: from dummy.name; Sun, 20 Sep 2009 15:09:45 -0600
In-Reply-To: Your message of "Sun, 20 Sep 2009 14:52:26 MDT."
             <auto-000020523806@sci.utah.edu> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128862>

tom fogal <tfogal@alumni.unh.edu> writes:
> Thiago Farina <tfransosi@gmail.com> writes:
> > -	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
> > +	"git log [options] [<since>..<until>] [[--] <path>...]\n"
> >  	"   or: git show [options] <object>...";
> 
> To me, "<blah>" implies to me that the other meant, "something which
                                         ^^^^^
... author.  sorry.

-tom
