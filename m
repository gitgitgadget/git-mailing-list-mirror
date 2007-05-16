From: picca <picca@synchrotron-soleil.Fr>
Subject: Re: newby question about merge.
Date: Wed, 16 May 2007 08:33:35 +0200
Organization: Soleil
Message-ID: <20070516083335.106667c5@localhost.localdomain>
References: <20070515113820.2621c8d5@localhost.localdomain>
	<f2c23k$dm0$1@sea.gmane.org>
	<20070515133720.20d76042@localhost.localdomain>
	<7vabw5iws8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 08:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoD4x-00019F-Sp
	for gcvg-git@gmane.org; Wed, 16 May 2007 08:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbXEPGdi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 02:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757317AbXEPGdi
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 02:33:38 -0400
Received: from dns2.synchrotron-soleil.fr ([195.221.0.6]:52391 "EHLO
	raclette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756431AbXEPGdh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2007 02:33:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 9DB5E78346;
	Wed, 16 May 2007 08:33:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from raclette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (raclette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pzrLHXkyyTxz; Wed, 16 May 2007 08:33:24 +0200 (CEST)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 765197833F;
	Wed, 16 May 2007 08:33:24 +0200 (CEST)
Received: from localhost.localdomain ([195.221.5.120]) by venusbis.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 16 May 2007 08:35:13 +0200
In-Reply-To: <7vabw5iws8.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-OriginalArrivalTime: 16 May 2007 06:35:13.0677 (UTC) FILETIME=[5BE833D0:01C79784]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47416>

On Tue, 15 May 2007 14:47:51 -0700
Junio C Hamano <junkio@cox.net> wrote:

> picca <picca@synchrotron-soleil.Fr> writes:
> 
> > Is it possible to add this git cat-file -p :2:filename > filename in
> > the man page of git-merge in the resolve conflict part ?
> >
> > Or a link to the documentation speaking of this stage part.
> 
> See:
> 
> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#conflict-resolution
> 
> As this walk through section from the user manual's already
> talks about it, I am not sure if we would want to duplicate its
> wording in git-merge manual page.

I had already red this manual but did not catch up that the :2:configure
was the git path of the files I want to retreive. In fact I was missing
the git-cat-file part and the git path.


regards, frederic
