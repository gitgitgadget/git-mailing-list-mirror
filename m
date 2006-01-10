From: walt <wa1ter@myrealbox.com>
Subject: Re: [PATCH] glossary: explain "master" and "origin"
Date: Tue, 10 Jan 2006 15:33:12 -0800
Organization: none
Message-ID: <dq1g7o$aqh$1@sea.gmane.org>
References: <Pine.LNX.4.63.0601102226130.649@wbgn013.biozentrum.uni-wuerzburg.de> <20060110213645.GF13450@fieldses.org> <dq1cdd$rob$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 11 00:33:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwSze-0003dl-MD
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 00:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbWAJXdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 18:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWAJXdc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 18:33:32 -0500
Received: from main.gmane.org ([80.91.229.2]:51398 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932705AbWAJXdb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 18:33:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EwSzR-0003bE-DR
	for git@vger.kernel.org; Wed, 11 Jan 2006 00:33:21 +0100
Received: from adsl-69-234-210-171.dsl.irvnca.pacbell.net ([69.234.210.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jan 2006 00:33:21 +0100
Received: from wa1ter by adsl-69-234-210-171.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jan 2006 00:33:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-210-171.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20060110)
In-Reply-To: <dq1cdd$rob$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14465>

walt wrote:
> J. Bruce Fields wrote:
> [...]
>> 	Most projects have one upstream
>> 	project which they track.  This is is the branch used for
>> 	tracking that project...
> 
> s/This/'origin'/
> 
> Lordy, I think many of the world's problems could be solved just
> by forbidding the use of pronouns entirely!

Now that I've had another beer, it occurs to me that a 'pronoun'
is nothing more or less than a 'pointer' to a noun.

Well!  We all know that pointers are a major source of bugs in
C code.  Is it possible that lint could be taught to detect
ambiguous pronouns in everyday speech?
