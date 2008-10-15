From: "Lars Hoss" <lars@woeye.net>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Wed, 15 Oct 2008 16:30:03 +0200 (CEST)
Message-ID: <5c7e37ffe7f7648398c2ddb313fdcf2a.squirrel@webmail.highteq.net>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
    <20081015124943.GA10816@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Lars Hoss" <lars@woeye.net>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 16:28:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq7MM-0001gN-CM
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 16:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbYJOO1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 10:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbYJOO1G
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 10:27:06 -0400
Received: from mail.codewut.de ([78.47.135.140]:57875 "EHLO mail.codewut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbYJOO1F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 10:27:05 -0400
Received: by mail.codewut.de (Postfix, from userid 65534)
	id 3A2E67BEF1; Wed, 15 Oct 2008 16:30:06 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on mail.codewut.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from webmail.highteq.net (web.highteq.net [78.47.135.138])
	by mail.codewut.de (Postfix) with ESMTP id A4BE37BE67;
	Wed, 15 Oct 2008 16:30:03 +0200 (CEST)
Received: from 194.127.8.18
        (SquirrelMail authenticated user lars)
        by webmail.highteq.net with HTTP;
        Wed, 15 Oct 2008 16:30:03 +0200 (CEST)
In-Reply-To: <20081015124943.GA10816@sigill.intra.peff.net>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98273>

> I wasn't able to reproduce your bug on my Linux box. Can you bisect to
> find the faulty commit?

Yes, you are right. This bug does neither appear on Linux nor on Windows
(mysysgit). So far it seems to be a OSX only bug.

Never used bisect myself before since I am new to git. But will try to do
my best - hehehe :)

Yours,
Lars
