From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 20:34:25 +0200
Organization: At home
Message-ID: <e2lq2l$64l$2@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org> <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org> <BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251106400.3701@g5.osdl.org> <BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Apr 25 20:34:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYSMg-00041X-SL
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 20:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWDYSeL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 14:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWDYSeL
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 14:34:11 -0400
Received: from main.gmane.org ([80.91.229.2]:18378 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932285AbWDYSeI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 14:34:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYSMO-0003xT-PO
	for git@vger.kernel.org; Tue, 25 Apr 2006 20:34:04 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 20:34:04 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 20:34:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19164>

sean wrote:

> On Tue, 25 Apr 2006 11:08:31 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>> Which is exactly what I told you to do. Just don't make it a git header.
> 
> Well I just don't see how making it a header, or plopping it at the
> end of a commit message makes an iota of difference to git, while it 
> [storing information in X-* like header] can help porcelain.

And [graphical] history browsers like gitk or qgit.

-- 
Jakub Narebski
Warsaw, Poland
