From: John Keeping <john@keeping.me.uk>
Subject: Re: Minor correction to Git book
Date: Wed, 8 May 2013 12:08:44 +0100
Message-ID: <20130508110844.GI25912@serenity.lan>
References: <71E08C07CB3C444098033ABD69925159145BB1DDE1@BATH-EXCMS.praxis.local>
 <20130508105141.GH25912@serenity.lan>
 <71E08C07CB3C444098033ABD69925159145BB1DE33@BATH-EXCMS.praxis.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Robin Messer <robin.messer@altran.com>
X-From: git-owner@vger.kernel.org Wed May 08 13:15:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua2LV-0004Tt-EU
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab3EHLPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:15:37 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48610 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab3EHLPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 07:15:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id DBA79866007;
	Wed,  8 May 2013 12:15:35 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AYNIPrQAnr6x; Wed,  8 May 2013 12:15:23 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 71199866046;
	Wed,  8 May 2013 12:15:15 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3E6DD161E5F3;
	Wed,  8 May 2013 12:08:54 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LyTnR8AA4gXL; Wed,  8 May 2013 12:08:49 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 9ECB7161E5DB;
	Wed,  8 May 2013 12:08:46 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <71E08C07CB3C444098033ABD69925159145BB1DE33@BATH-EXCMS.praxis.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223656>

On Wed, May 08, 2013 at 12:01:00PM +0100, Robin Messer wrote:
> > I think the text is correct as it stands.  "git status" shows you that
> > there are changes that are staged and unstaged, "git diff" (and "git
> > diff --cached") shows you what those changes are.
> 
> Thanks, but the command line which follows that text does actually use
> "git status" to show which files (staged and unstaged) have changes.
> The text I quoted is introducing that command.
> 
> Then the next example shows you how to use "git diff" to see what the
> actual unstaged changes to those files are.

Ah, OK.  I read your email without looking at the context.

> If this is not the appropriate place to report such things, please point
> me at the correct one.

The ProGit book is maintained at https://github.com/progit/progit
