X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] E-mail aliases
Date: Tue, 12 Dec 2006 11:35:14 -0800
Message-ID: <20061212193513.GA3984@localdomain>
References: <b0943d9e0612120449k4a13ac85t313df1e460ed46e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 19:35:37 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0612120449k4a13ac85t313df1e460ed46e4@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34136>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuDPT-00034S-HV for gcvg-git@gmane.org; Tue, 12 Dec
 2006 20:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932403AbWLLTfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 14:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWLLTfZ
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 14:35:25 -0500
Received: from hand.yhbt.net ([66.150.188.102]:53995 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932403AbWLLTfY
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 14:35:24 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 9E36C7DC02A; Tue, 12 Dec 2006 11:35:22 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 12 Dec 2006
 11:35:14 -0800
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> Hi,
> 
> I added a feature to StGIT (not released yet) so that one can specify
> an alias instead of a complete e-mail address on the command line (or
> in the template file), i.e.:
> 
>  stg mail --to=lkml

git-send-email can be configured to parse mutt, mailrc, pine and gnu
alias files.  I use the mutt one extensively myself and find it very
useful.

-- 
