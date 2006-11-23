X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Thu, 23 Nov 2006 18:45:58 -0500
Message-ID: <20061123234558.GA29170@fieldses.org>
References: <20061123225835.30071.99265.stgit@machine.or.cz> <7vejrtiwqd.fsf@assigned-by-dhcp.cox.net> <20061123234203.GN7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 23:46:14 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061123234203.GN7201@pasky.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32179>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnOGf-0005Qn-T2 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757502AbWKWXqG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757503AbWKWXqG
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:46:06 -0500
Received: from mail.fieldses.org ([66.93.2.214]:53694 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S1757502AbWKWXqE
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:46:04 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GnOGU-0000On-UD; Thu, 23 Nov 2006
 18:45:58 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On Fri, Nov 24, 2006 at 12:42:03AM +0100, Petr Baudis wrote:
> On Fri, Nov 24, 2006 at 12:12:10AM CET, Junio C Hamano wrote:
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> > > and --use-immingled-remote can be used to get the original behaviour;
> > > it is also implied by --bare.
> > 
> > What's immingled?
> 
> One dictionary says
> 
>    Immingle \Im*min"gle\, v. t.
>       To mingle; to mix; to unite; to blend. [R.] --Thomson.
> 
> but perhaps it's too much an obscure word... better suggestions
> welcomed.

commingled? legacy? flat?

