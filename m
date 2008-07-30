From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: cvs diff -l equivalent?
Date: Wed, 30 Jul 2008 17:58:53 +0200
Message-ID: <20080730155853.GA27166@cuci.nl>
References: <20080730082030.GA12555@cuci.nl> <alpine.LSU.1.00.0807301553030.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 17:59:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOE5m-0002jJ-0r
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 17:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbYG3P64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 11:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbYG3P6z
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 11:58:55 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:47063 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbYG3P6y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 11:58:54 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 2BCD45466; Wed, 30 Jul 2008 17:58:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0807301553030.3486@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90810>

Johannes Schindelin wrote:
>On Wed, 30 Jul 2008, Stephen R. van den Berg wrote:
>> Someone popped this question on me.

>I do not know cvs that well anymore.  So I do not know what -l does.  Care 
>to explain?

Usage: cvs diff [-lR] [-k kopt] [format_options]
    [[-r rev1 | -D date1] [-r rev2 | -D date2]] [files...]
        -l      Local directory only, not recursive

It shows the diff for all files in the current directory, nothing
deeper, nothing higher.

>> How many weeks are there in a lightyear?
>That is easy.  52 light ones.

I presume you mean "lightweeks", and yes, that would probably fit the bill :-).
-- 
Sincerely,
           Stephen R. van den Berg.
