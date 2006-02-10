From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on "status -v"
Date: Fri, 10 Feb 2006 15:26:31 -0800
Message-ID: <7v3biqvlqw.fsf@assigned-by-dhcp.cox.net>
References: <87slqtcr2f.wl%cworth@cworth.org>
	<7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602081726390.2458@g5.osdl.org>
	<7vmzgzy46f.fsf@assigned-by-dhcp.cox.net>
	<87u0b7uf91.wl%cworth@cworth.org>
	<7vaccyx6ne.fsf@assigned-by-dhcp.cox.net>
	<20060210225109.GQ31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 00:26:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7heu-0005Rx-7f
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 00:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWBJX0e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 18:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWBJX0e
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 18:26:34 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:31448 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932235AbWBJX0d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 18:26:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210232524.FHBY15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 18:25:24 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060210225109.GQ31278@pasky.or.cz> (Petr Baudis's message of
	"Fri, 10 Feb 2006 23:51:09 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15899>

Petr Baudis <pasky@suse.cz> writes:

>> That is a good argument for (1).  Since the diff output never
>> has '^---$' in itself,
>
> $ echo -- >a; >b; diff -u a b

Thanks.  Good point.  Forget what I said.
