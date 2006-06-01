From: Ryan Anderson <ryan@michonline.com>
Subject: Re: What's in git.git (part #2)
Date: Thu, 1 Jun 2006 15:51:54 -0700
Message-ID: <20060601225152.GG32457@h4x0r5.com>
References: <7v64jli66m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 00:52:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Flw1k-0007dc-39
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 00:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWFAWwB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 18:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWFAWwB
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 18:52:01 -0400
Received: from h4x0r5.com ([70.85.31.202]:39429 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1750840AbWFAWwA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 18:52:00 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1Flw1C-0002oQ-6H; Thu, 01 Jun 2006 15:51:54 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64jli66m.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21125>

On Thu, Jun 01, 2006 at 02:19:45AM -0700, Junio C Hamano wrote:
> Things that we might want to have in 1.4.0 but not even in "next"
> yet include:
> 
>  - p4 importer (Sean Estabrooks) -- are people interested?

I think adding more importers is a good thing.  There's no sense in
having people reinvent the wheel.

Which reminds me, I need to polish and send off my BitKeeper importer.
(It's slow and dumb, but works.)
