From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH/RFC 0/4] gitweb: ViewVC-like "tree_blame" view
Date: Thu, 31 Aug 2006 02:47:05 +0200
Message-ID: <200608310247.05385.Josef.Weidendorfer@gmx.de>
References: <200608310043.12606.jnareb@gmail.com> <7vfyfdg4fw.fsf@assigned-by-dhcp.cox.net> <ed59rk$hk0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 02:47:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIaiJ-0006Zu-Jp
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 02:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWHaArJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 20:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWHaArJ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 20:47:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:10665 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932261AbWHaArI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Aug 2006 20:47:08 -0400
Received: (qmail invoked by alias); 31 Aug 2006 00:47:06 -0000
Received: from p5496C0BC.dip0.t-ipconnect.de (EHLO noname) [84.150.192.188]
  by mail.gmx.net (mp020) with SMTP; 31 Aug 2006 02:47:06 +0200
X-Authenticated: #352111
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <ed59rk$hk0$1@sea.gmane.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26241>

On Thursday 31 August 2006 02:18, Jakub Narebski wrote:
> Ooops, I forgot to explain this. Strike-through, which actually should be
> using different color like red for example means that the file has 1-commit
> long history, i.e. it just appeared in given commit.

Seems useful. Perhaps better green. And red for...
(As you talk about "just appeared") What's about deleted files, similar
to attic in CVS? It could be quite useful to provide an alternate
tree-blame mode including deleted files; where the given commit
would specify the deletion.

Josef
