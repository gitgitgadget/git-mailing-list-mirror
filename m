From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 14:15:56 -0800
Message-ID: <7v4q49ks83.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
	<7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net> <43C6CFC5.5010902@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Thu Jan 12 23:16:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExAk2-0005pI-2m
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 23:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161362AbWALWP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 17:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161360AbWALWP7
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 17:15:59 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:14992 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161362AbWALWP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 17:15:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112221328.MKRF17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 17:13:28 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C6CFC5.5010902@op5.se> (Andreas Ericsson's message of "Thu, 12
	Jan 2006 22:53:09 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14593>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>
>> ... let's say an
>> office-mate edited things for you and said "this should work.
>> test it out and if it is OK commit it for me."...
>
> This happens from time to time where I work, but I think it would be
> more useful to have
>
> 	--from="Some User <some.user@theoffice.org>"
>

I agree this would be more useful, direct, easy to understand
and explain way to do it.
