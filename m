From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 1/4] Add diff-diff, which compares the diffs of two commits
Date: Sat, 15 Dec 2007 16:55:14 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712151654060.27959@racer.site>
References: <1197737505128-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Dec 15 17:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3aIw-00022t-42
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 17:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664AbXLOQzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 11:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756543AbXLOQzg
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 11:55:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:54715 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756122AbXLOQzf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 11:55:35 -0500
Received: (qmail invoked by alias); 15 Dec 2007 16:55:33 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp004) with SMTP; 15 Dec 2007 17:55:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VF40paMpVg97AcRr8jkPWRTyqZA/5FZSrWzsNSo
	MiTB1E9sVHXxtJ
X-X-Sender: gene099@racer.site
In-Reply-To: <1197737505128-git-send-email-prohaska@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68398>

Hi,

On Sat, 15 Dec 2007, Steffen Prohaska wrote:

> The following patch series adds experimental diff-diff support. It adds 
> a very basic command line version and experimental gitk support for 
> displaying the differences between the patches associated with two 
> commits.

I briefly considered adding something like interdiff a year ago, but 
decided that installing patchutils and having an alias was enough for my 
needs.

IOW I do not need this to be a git command.

Ciao,
Dscho
