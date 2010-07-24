From: "Chris.Cheney" <chris.cheney.nospam@tesco.net>
Subject: Re: [PATCH] Documentation: Explain git-mergetool's use of temporary files
Date: Sat, 24 Jul 2010 16:30:30 +0000 (UTC)
Message-ID: <Xns9DBFB2486416AChrisCheneytesconet@80.91.229.10>
References: <1279417608-6442-1-git-send-email-davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 18:30:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ochck-0001Ir-Ur
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 18:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870Ab0GXQak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 12:30:40 -0400
Received: from lo.gmane.org ([80.91.229.12]:35056 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754819Ab0GXQaj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 12:30:39 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OchcU-0001DP-Dl
	for git@vger.kernel.org; Sat, 24 Jul 2010 18:30:38 +0200
Received: from 82.18.202.19 ([82.18.202.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 18:30:38 +0200
Received: from chris.cheney.nospam by 82.18.202.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 18:30:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 82.18.202.19
User-Agent: Xnews/5.04.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151661>

David Aguilar <davvid@gmail.com> wrote in
news:1279417608-6442-1-git-send-email-davvid@gmail.com: 

> 'git mergetool' creates '*.orig' backup files in its
> default configuration.  Mention this in its documentation.
<snip>

Thanks
