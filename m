From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Extra columns in blame
Date: Fri, 18 May 2007 17:18:26 -0700
Message-ID: <7vy7jl3bu5.fsf@assigned-by-dhcp.cox.net>
References: <20070518191725.10460.83338.stgit@rover>
	<7vy7jl4zjm.fsf@assigned-by-dhcp.cox.net>
	<20070518221916.GZ4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat May 19 02:18:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCeX-0003FC-Bg
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbXESAS2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 20:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753144AbXESAS2
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:18:28 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:39357 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbXESAS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 20:18:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519001826.PGYR19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 18 May 2007 20:18:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0oJS1X0021kojtg0000000; Fri, 18 May 2007 20:18:26 -0400
In-Reply-To: <20070518221916.GZ4489@pasky.or.cz> (Petr Baudis's message of
	"Sat, 19 May 2007 00:19:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47694>

Petr Baudis <pasky@suse.cz> writes:

>> Also the incremental thing using JavaScript does not seem to
>> work for me incrementally for some reason, although if I wait
>> long enough I get the fully blamed picture that seems to match
>> nonincremental one.  While I am waiting, the browser goes silent
>> and does not even let me switch to other tabs, so it is not all
>> that useful to me in its current shape.
>
> Strange, what browser are you using?

Firefox (I think it is 2.0) running on a W2k box behind two http
proxies.
