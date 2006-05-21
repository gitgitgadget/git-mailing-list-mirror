From: Jim Meyering <jim@meyering.net>
Subject: Re: synchronizing incremental git changes to cvs
Date: Sun, 21 May 2006 18:37:55 +0200
Message-ID: <87r72niba4.fsf@rho.meyering.net>
References: <87mzdcjqey.fsf@rho.meyering.net>
	<46a038f90605201709n3a840fd9n7e85a289f49a3c5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 18:38:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhqwQ-0006dn-3T
	for gcvg-git@gmane.org; Sun, 21 May 2006 18:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWEUQh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 12:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWEUQh5
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 12:37:57 -0400
Received: from mx.meyering.net ([82.230.74.64]:10722 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S964898AbWEUQh5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 12:37:57 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 9E02D34A8E; Sun, 21 May 2006 18:37:55 +0200 (CEST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605201709n3a840fd9n7e85a289f49a3c5f@mail.gmail.com>
	(Martin Langhoff's message of "Sun, 21 May 2006 12:09:19 +1200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20454>

"Martin Langhoff" <martin.langhoff@gmail.com> wrote:
> git-cvsserver is the word. It currently tracks the git repo itself
> pretty well (perfectly, AFAICS) and it also tracks a git tree that is
> actually imported daily from CVS -- doing
>
>    CVSrepo ->cvsimport -> GIT -> cvsserver -> CVS checkout

Thanks, but I'd rather do primary development directly using git,
rather than with CVS.
