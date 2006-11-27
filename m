X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Mozilla, git and Windows
Date: Mon, 27 Nov 2006 23:13:38 +0100
Message-ID: <20061127221338.GP7201@pasky.or.cz>
References: <9e4733910611270728p36e58e08w6cc7a2989b7843ce@mail.gmail.com> <456B057E.4000904@shadowen.org> <9e4733910611270813g4ff982b0tbe6b57d1d49ca9f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 22:14:06 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <9e4733910611270813g4ff982b0tbe6b57d1d49ca9f7@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32456>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoojP-0005mq-GV for gcvg-git@gmane.org; Mon, 27 Nov
 2006 23:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933914AbWK0WNl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 17:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933924AbWK0WNk
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 17:13:40 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60590 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S933914AbWK0WNk (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 17:13:40 -0500
Received: (qmail 1887 invoked by uid 2001); 27 Nov 2006 23:13:38 +0100
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, Nov 27, 2006 at 05:13:10PM CET, Jon Smirl wrote:
> The SVN version of the Mozilla repository is about 3GB. It takes
> around a week of CPU time for svnimport to process it.

Is there a reason why a SVN importer would _have_ to take _longer_ than
a CVS importer? I'd expect the opposite from an optimized importer since
you don't have to guess the changesets...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
