From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Mon, 01 May 2006 08:56:36 +0200
Organization: At home
Message-ID: <e34bdf$ho4$1@sea.gmane.org>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 01 08:56:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaSK8-0008BD-60
	for gcvg-git@gmane.org; Mon, 01 May 2006 08:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWEAGzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 02:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWEAGzz
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 02:55:55 -0400
Received: from main.gmane.org ([80.91.229.2]:64401 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751287AbWEAGzy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 May 2006 02:55:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FaSJy-00089T-Gp
	for git@vger.kernel.org; Mon, 01 May 2006 08:55:50 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 May 2006 08:55:50 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 May 2006 08:55:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19372>

Junio C Hamano wrote:

> This attempts to set up built-in "git grep" to further reduce
> our dependence on the shell, while at the same time optionally
> allowing to run grep against object database.
[...]
> In order to stay out of the way of real work people want to get
> done with the real "git grep", for now this implementation is
> called "git grip".

Wouldn't "git ggrep" (from git-aware grep) or "git bgrep" (from built-in
grep), similar to the egrep and fgrep from the grep package?

-- 
Jakub Narebski
Warsaw, Poland
