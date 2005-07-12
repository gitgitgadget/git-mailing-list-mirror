From: Thomas Lord <lord@emf.net>
Subject: Re: arch 2.0 first source available (git related)
Date: Mon, 11 Jul 2005 17:05:57 -0700
Message-ID: <1121126757.24076.2.camel@dev1.seyza.com>
References: <1120867947.5882.2.camel@dev1.seyza.com>
	 <20050709113942.GB26343@pasky.ji.cz>
	 <1120918813.4901.27.camel@dev1.seyza.com>
	 <20050711193944.GA5981@pasky.ji.cz>
	 <1121117816.16511.5.camel@dev1.seyza.com>
	 <20050711233150.GB5981@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 02:13:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds8Oh-0001XX-F6
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 02:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVGLAIu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 20:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVGLAHb
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 20:07:31 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:2725 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262306AbVGLAFo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 20:05:44 -0400
Received: (qmail 55935 invoked from network); 12 Jul 2005 00:05:39 -0000
Received: from unknown (HELO adsl-69-236-72-120.dsl.pltn13.pacbell.net) (tom.lord@sbcglobal.net@69.236.72.120 with plain)
  by smtp109.sbc.mail.mud.yahoo.com with SMTP; 12 Jul 2005 00:05:39 -0000
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050711233150.GB5981@pasky.ji.cz>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-07-12 at 01:31 +0200, Petr Baudis wrote:

> But if the depth will be less than that, won't the user end up with some
> (plenty) of the objects duplicated?


Some, yes, many, no.   It's pretty easy to tune how many, afaict.

-t
