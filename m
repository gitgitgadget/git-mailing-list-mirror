X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Sun, 10 Dec 2006 13:47:35 +0200
Message-ID: <20061210114735.GA11107@sashak.voltaire.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com> <20061208203230.GA9193@sashak.voltaire.com> <4b3406f0612091949qc75cb10x13f09e2017d71d91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 11:39:53 +0000 (UTC)
Cc: Daniel Drake <ddrake@brontes3d.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4b3406f0612091949qc75cb10x13f09e2017d71d91@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 10 Dec 2006 11:39:43.0823 (UTC) FILETIME=[E2E87DF0:01C71C4F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33877>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtN26-0006Wn-Ll for gcvg-git@gmane.org; Sun, 10 Dec
 2006 12:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758294AbWLJLjr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 06:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758303AbWLJLjr
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 06:39:47 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:9002 "EHLO
 taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758292AbWLJLjr (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 06:39:47 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft
 SMTPSVC(6.0.3790.1830); Sun, 10 Dec 2006 13:39:43 +0200
Received: by sashak (sSMTP sendmail emulation); Sun, 10 Dec 2006 13:47:35
 +0200
To: Dongsheng Song <dongsheng.song@gmail.com>
Sender: git-owner@vger.kernel.org

On 11:49 Sun 10 Dec     , Dongsheng Song wrote:
> I met the broken too, when I downgrade to 1.4.3.4, it's fine.
> 
> I have not test your patch, but you can try your self,
> 
> http://tortoisesvn.tigris.org/svn/tortoisesvn
> 
> and the master branch(today) fail between r6000~r7000 too

Thanks for the link. but I cannot access - this requires
username/password authentication.

