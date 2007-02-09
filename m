From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7/7] git-blame.el: Autoupdate while editing
Date: Fri, 09 Feb 2007 10:46:40 +0100
Organization: At home
Message-ID: <eqhfqv$bnu$1@sea.gmane.org>
References: <87ejozpwp0.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 10:45:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFSJp-0002FC-NE
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 10:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946271AbXBIJpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 04:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946278AbXBIJpW
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 04:45:22 -0500
Received: from main.gmane.org ([80.91.229.2]:55213 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946271AbXBIJpV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 04:45:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFSJj-0001yc-88
	for git@vger.kernel.org; Fri, 09 Feb 2007 10:45:19 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 10:45:19 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 10:45:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39171>

[Cc: git@vger.kernel.org]

David K?gedal wrote:

> This adds the support for automatically updating the buffer while editing.
> A configuration variable git-blame-autoupdate controls whether this should
> be enabled or not.

Can we use -L option of git-blame for this?

BTW did you take a look at Font Lock modes: Fast Lock mode, Lazy Lock mode,
Just-in-time Lock mode?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
