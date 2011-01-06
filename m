From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git color in commit editor
Date: Thu, 6 Jan 2011 11:06:50 +0100
Message-ID: <201101061106.50636.trast@student.ethz.ch>
References: <AANLkTimMZaSW4ZUS60Vo38vyuq-PPqPhGdCVZjFzF2Gs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Pavan Savoy <pavan_savoy@sify.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 11:06:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PamkD-0007AY-H6
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 11:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab1AFKGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 05:06:52 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:37537 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399Ab1AFKGv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 05:06:51 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 6 Jan
 2011 11:06:40 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 6 Jan
 2011 11:06:50 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc8-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <AANLkTimMZaSW4ZUS60Vo38vyuq-PPqPhGdCVZjFzF2Gs@mail.gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164626>

Pavan Savoy wrote:
> On another machine with same vim version and same gitconfig and pretty
> much all the same settings except that the
> git version is git version 1.6.3.3, I don't have color in the commit editor...
> 
> Moving to newer GIT versions didn't help either...
> What am I missing?

That's squarely in vim's domain, git does not (and cannot) impose any
colors on the editor.  So you need to configure vim on the second
machine for the highlighting.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
