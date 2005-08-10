From: Chris Wright <chrisw@osdl.org>
Subject: Re: Cannot install git RPM
Date: Wed, 10 Aug 2005 09:32:24 -0700
Message-ID: <20050810163224.GF8041@shell0.pdx.osdl.net>
References: <20050810003012.GB22778@mythryan2.michonline.com> <20050810074607.30803353C46@atlas.denx.de> <20050810162307.GE8041@shell0.pdx.osdl.net> <20050810163202.GA11131@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, Wolfgang Denk <wd@denx.de>,
	Ryan Anderson <ryan@michonline.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 18:32:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2tVN-0000u6-ME
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 18:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbVHJQce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 12:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVHJQce
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 12:32:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64706 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965196AbVHJQce (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2005 12:32:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7AGWOjA008103
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 Aug 2005 09:32:25 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7AGWO0s030193;
	Wed, 10 Aug 2005 09:32:24 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j7AGWO0D030192;
	Wed, 10 Aug 2005 09:32:24 -0700
To: Sam Ravnborg <sam@ravnborg.org>
Content-Disposition: inline
In-Reply-To: <20050810163202.GA11131@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.41__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Sam Ravnborg (sam@ravnborg.org) wrote:
> Not knowing perl at all I wonder if some more widespread used packages
> can replace the above two?
> I recall having trouble locating them myself when I first tried Greg's
> send-a-lot-of-mails script.

I'm not too sure, but I too abandoned (well, rewrote in sh) some email
scripts from Greg due to that dependency ;-)

thanks,
-chris
