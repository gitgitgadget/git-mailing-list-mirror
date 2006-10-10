From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 11:23:43 -0700 (PDT)
Message-ID: <20061010182343.18986.qmail@web31808.mail.mud.yahoo.com>
References: <200610101514.20705.Josef.Weidendorfer@gmx.de>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 10 20:25:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXMGw-0003qS-Ih
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 20:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWJJSXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 14:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWJJSXq
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 14:23:46 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:3217 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965028AbWJJSXo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 14:23:44 -0400
Received: (qmail 18988 invoked by uid 60001); 10 Oct 2006 18:23:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RrK+pF9h/Cbae2f7nbW0tfPsVKNo+2hVAphyJ52Hx0Lhq1o0bH4YRTSOOuQ3ifWVm6iABwqRUTuFLk7KlCxbLaaL4IQ2Na4QYVXLb6gDiKYowNz+GTVZJOhF5AHeI20MtldLv8IKaiwdLbcAYz6r6EkAdPHiXsz0gReON4uvZkI=  ;
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Tue, 10 Oct 2006 11:23:43 PDT
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Andreas Ericsson <ae@op5.se>
In-Reply-To: <200610101514.20705.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28650>

--- Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> One thing I found confusing in this regard the first time:
> Why do list rows show a recoloring with mouse over?

It's a highlight and it's a good highlight.  It suggests that the
row is "alive", i.e. that the title is clickable.  It "shows" you
your current "selection" by having the mouse pointer over the row.

I like it.

    Luben
