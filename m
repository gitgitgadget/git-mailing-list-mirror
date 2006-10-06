From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Decode long title for link tooltips
Date: Fri, 06 Oct 2006 10:54:46 +0200
Organization: At home
Message-ID: <eg55jb$nar$1@sea.gmane.org>
References: <873baet4ka.wl@mail2.atmark-techno.com> <871wpyt3ch.wl@mail2.atmark-techno.com> <87zmcmroqf.wl@mail2.atmark-techno.com> <eforb7$fgd$1@sea.gmane.org> <87r6xrvi0g.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 06 11:00:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVlXi-0007cl-S5
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 10:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWJFI6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 04:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWJFI6v
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 04:58:51 -0400
Received: from main.gmane.org ([80.91.229.2]:54930 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751355AbWJFI6v (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 04:58:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GVlUq-0006sK-S9
	for git@vger.kernel.org; Fri, 06 Oct 2006 10:55:57 +0200
Received: from host-81-190-18-48.torun.mm.pl ([81.190.18.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 10:55:56 +0200
Received: from jnareb by host-81-190-18-48.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 10:55:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-48.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28392>

Yasushi SHOJI wrote:

[...]]
> Subject: [PATCH] gitweb: refactor decode() for utf8 conversion
> 
> we already had a few place using decode() to convert perl internal
> encode to utf8.  added a new thin wrapper to do just that.
> 
> Signed-off-by: Yasushi SHOJI <yashi@atmark-techno.com>

What happened to this patch? Dropped or omitted by mistake?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
