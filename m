From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Make more commands builtin
Date: Tue, 23 May 2006 14:36:54 +0200
Organization: At home
Message-ID: <e4uvku$o28$1@sea.gmane.org>
References: <20060523122056.GA5777@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue May 23 14:37:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiW8L-0006zw-ID
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWEWMhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWEWMhE
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:37:04 -0400
Received: from main.gmane.org ([80.91.229.2]:64641 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932187AbWEWMhD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:37:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FiW86-0006wN-9Q
	for git@vger.kernel.org; Tue, 23 May 2006 14:36:54 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 May 2006 14:36:54 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 May 2006 14:36:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20602>

Peter Eriksen wrote:

> Btw.
> 
> I used these commands to produce the patch series:
> 
> git diff --stat -C 24b65a30015aedd..pe/builtin
> git-send-email --no-chain-reply-to --compose \
>                --from=s022018@student.dtu.dk --not-signed-off-by-cc \
>                --quiet \
>                --subject="Make more commands builtin" \
>                --to=git@vger.kernel.org Patches/*

I wonder why the patches themselves are not replies to the main/summary
email, i.e. "Make more commands builtin" email...

-- 
Jakub Narebski
Warsaw, Poland
