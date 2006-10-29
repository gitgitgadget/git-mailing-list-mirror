X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Sun, 29 Oct 2006 12:24:54 -0600
Message-ID: <20061029182454.GT17019@over-yonder.net>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl> <4541D291.5020205@op5.se> <20061027144656.GA32451@fieldses.org> <m3mz7gheoe.fsf@iny.iki.fi> <ehvnal$tjg$1@sea.gmane.org> <m3fyd77gsn.fsf@iny.iki.fi> <ei2563$m1u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 18:25:25 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ei2563$m1u$1@sea.gmane.org>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30436>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeFLO-00026R-MS for gcvg-git@gmane.org; Sun, 29 Oct
 2006 19:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965319AbWJ2SY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 13:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbWJ2SY5
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 13:24:57 -0500
Received: from ns.centralmiss.com ([206.156.254.79]:11971 "EHLO
 optimus.centralmiss.com") by vger.kernel.org with ESMTP id S965323AbWJ2SY4
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 13:24:56 -0500
Received: from draco.over-yonder.net
 (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213]) (using TLSv1
 with cipher ADH-AES256-SHA (256/256 bits)) (No client certificate requested)
 by optimus.centralmiss.com (Postfix) with ESMTP id C984228430; Sun, 29 Oct
 2006 12:24:54 -0600 (CST)
Received: by draco.over-yonder.net (Postfix, from userid 100) id 44F5E61C52;
 Sun, 29 Oct 2006 12:24:54 -0600 (CST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Sun, Oct 29, 2006 at 01:01:07PM +0100 I heard the voice of
Jakub Narebski, and lo! it spake thus:
> 
> Branch-centric and repo-centric SCM promote different workflows,
> namely parallel uncommited work on few development branches for
> branch-centric SCM, one-change per-commit multiple temporary and
> feature branches for repo-centric SCM.

I don't think that follows at all.


> Do you really often compile and run other branch while developing on
> other?

Yes.  And I do the same with older revisions along a given branch too,
where is where [lightweight] checkouts come in handy.


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
