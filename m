From: Gelonida <gelonida@gmail.com>
Subject: Re: simple example for git hooks
Date: Sun, 05 Sep 2010 23:48:41 +0200
Message-ID: <i6137p$uet$1@dough.gmane.org>
References: <i5p96s$u7q$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 23:49:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsN5F-0001A4-9K
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 23:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503Ab0IEVs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 17:48:59 -0400
Received: from lo.gmane.org ([80.91.229.12]:47047 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465Ab0IEVs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 17:48:58 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OsN52-000141-EL
	for git@vger.kernel.org; Sun, 05 Sep 2010 23:48:52 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 23:48:52 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 23:48:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 ""
In-Reply-To: <i5p96s$u7q$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155492>

Hi everybody,
On 09/03/2010 12:41 AM, Gelonida wrote:
> Does anyone have a simple example of a git pre-commit hook
> 
> 
> I have difficulties finding understandable tutorals about git hooks.
> 
> 
> 
> 
> What I am looking at is basic examples about
> 
> 
> precommit hooks
> ================
> 
> - how to get list of modified files
> 
Thanks for all your answers.
I'm currently using
git diff-index HEAD --cached

This seems to do what I was looking for.
