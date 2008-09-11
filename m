From: Jeff King <peff@peff.net>
Subject: Re: Git User's Survey 2008 partial summary, part 5 - other SCM
Date: Thu, 11 Sep 2008 17:54:29 -0400
Message-ID: <20080911215429.GC3187@coredump.intra.peff.net>
References: <200809031607.19722.jnareb@gmail.com> <200809112214.18366.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 23:55:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdu8Y-0003vC-Vq
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 23:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbYIKVyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 17:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbYIKVyb
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 17:54:31 -0400
Received: from peff.net ([208.65.91.99]:1334 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926AbYIKVyb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 17:54:31 -0400
Received: (qmail 6042 invoked by uid 111); 11 Sep 2008 21:54:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 11 Sep 2008 17:54:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Sep 2008 17:54:29 -0400
Content-Disposition: inline
In-Reply-To: <200809112214.18366.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95653>

On Thu, Sep 11, 2008 at 10:14:17PM +0200, Jakub Narebski wrote:

> SCM                    |  Never     | Used it    | Still use
> --------------------------------------------------------------
[...]
> CVS                    | 12%  (242) | 62% (1277) | 13%  (260) 1 

I like to think of this as 1017 monitors that we have saved from getting
punched in frustration.

> 25) How do you publish/propagate your changes? 
>     (Choice - Multiple answers)
> 
> ======================================
> method                  | using it                
> --------------------------------------
> push                    | 91%  (1740)

Obviously a quite popular choice. I wonder if this could be broken down
more in next year's survey:

  - push into my public repo, interested people pull
  - push into central repo

-Peff
