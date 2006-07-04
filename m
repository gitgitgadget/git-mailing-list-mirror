From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: git-fetch per-repository speed issues
Date: Tue, 4 Jul 2006 18:30:50 +0200
Message-ID: <20060704163050.GT3305@cip.informatik.uni-erlangen.de>
References: <1151949764.4723.51.camel@neko.keithp.com> <e8e28j$v8v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 18:32:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxnna-0008NZ-Oy
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 18:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWGDQaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 12:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWGDQav
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 12:30:51 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:25278 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S932273AbWGDQav (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 12:30:51 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 2E2E530DF6; Tue,  4 Jul 2006 18:30:50 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e8e28j$v8v$1@sea.gmane.org>
User-Agent: Mutt/1.5.11-2006-06-13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23302>

Hello,

> See summary at
> http://git.or.cz/gitwiki/GitBenchmarks#head-85df1bb7f019c4c504e34cde43450ef69349882f

thank you for clarifing! I finally understand why Solaris folks prefer
hg over git: It is dog slow. - So it fits the general philosophy behind
Solaris.

        Thomas
