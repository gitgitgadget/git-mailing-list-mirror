From: Dean Pulsifer <pulsifer@lexmark.com>
Subject: Re: gitk:
Date: Sat, 12 Sep 2015 20:04:28 +0000 (UTC)
Message-ID: <loom.20150912T220334-422@post.gmane.org>
References: <CAL_Ays8piaRHk6BxDOBLYbrxoN4wt3bLB0Pt8K6NydOBCi9dzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 22:30:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZarRZ-0001wh-02
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 22:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbbILUaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 16:30:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:47716 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbbILUaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 16:30:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZarQx-0000pG-RO
	for git@vger.kernel.org; Sat, 12 Sep 2015 22:30:04 +0200
Received: from 192.146.101.71 ([192.146.101.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 22:30:03 +0200
Received: from pulsifer by 192.146.101.71 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 22:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.146.101.71 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:40.0) Gecko/20100101 Firefox/40.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277736>

Chris Cowan <cowan <at> streak.com> writes:

> 
> I've recently had an issue where running "gitk --all" has stopped
> working on a large repository of mine. Gitk's main window appears with
> all of the sections empty, and a modal tells me 'Error executing git
> log: couldn't execute "git": argument list too long'.
> 
> I'm on OS X, and am running git version 2.4.3 installed via homebrew.

I am also seeing this just as of this week.  Did you find a solution?
