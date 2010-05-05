From: Jeff King <peff@peff.net>
Subject: Re: newbie: need concrete examples for how the linux-kernel
 project uses git
Date: Tue, 4 May 2010 21:09:33 -0400
Message-ID: <20100505010933.GD25390@coredump.intra.peff.net>
References: <m2i408104421005041431l6c8b5845ld57720c2127fbb00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 03:10:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9T7u-00046Q-KF
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 03:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760151Ab0EEBJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 21:09:37 -0400
Received: from peff.net ([208.65.91.99]:46851 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755869Ab0EEBJg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 21:09:36 -0400
Received: (qmail 16566 invoked by uid 107); 5 May 2010 01:09:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 04 May 2010 21:09:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 May 2010 21:09:33 -0400
Content-Disposition: inline
In-Reply-To: <m2i408104421005041431l6c8b5845ld57720c2127fbb00@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146362>

On Tue, May 04, 2010 at 05:31:21PM -0400, Robert Buck wrote:

> However, I find it rather challenging finding any subject matter that
> provides reasonable detail. What I'd like to find are concrete
> examples, step-by-step, of specifically how to:

This is not quite what you're asking for, but you may find the following
helpful:

  An overview of some workflows.
  http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html

  A description of the maintainer workflow for git itself:
  http://www.kernel.org/pub/software/scm/git/docs/howto/maintain-git.txt

-Peff
