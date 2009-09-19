From: Resul Cetin <Resul-Cetin@gmx.net>
Subject: Re: shell commands in ReleaseNotes
Date: Sun, 20 Sep 2009 00:40:49 +0200
Message-ID: <200909200040.50009.Resul-Cetin@gmx.net>
References: <200909192357.32369.Resul-Cetin@gmx.net> <7veiq27ekz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 00:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mp8eQ-00017j-P6
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 00:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbZISWkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2009 18:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbZISWkw
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 18:40:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:39279 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750755AbZISWkw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2009 18:40:52 -0400
Received: (qmail invoked by alias); 19 Sep 2009 22:40:55 -0000
Received: from unknown (EHLO resul-server) [89.246.210.205]
  by mail.gmx.net (mp012) with SMTP; 20 Sep 2009 00:40:55 +0200
X-Authenticated: #15668376
X-Provags-ID: V01U2FsdGVkX1/bU0xegvvbC/AZqU8lh8KO+l5MkrPQ3P7pHDIAOc
	8tiWdq68M2ukkp
User-Agent: KMail/1.12.1 (Linux/2.6.31-rc5; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7veiq27ekz.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128830>

> Resul Cetin <Resul-Cetin@gmx.net> writes:
> > Real nice idea to create an overview about changes in a repository for
> > writing a releasenotes. But how is it real used by the maintainer?
> 
> Open the file, go to the beginning of the scriptlet and mark (\C-SP), go
> to the end (\M->), feed it to shell (\M-| sh RET), open /var/tmp/1 and
> read it over while cutting the updated definition of O=.
> 
> Everything done in Emacs, no need for any extra editor.
Ah, thanks. Looks like a good workflow.
