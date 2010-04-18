From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Multiple user.name and user.email (possible feature request)
Date: Sun, 18 Apr 2010 16:53:15 -0400
Message-ID: <19403.28987.941803.339268@winooski.ccs.neu.edu>
References: <19402.52486.274010.66636@winooski.ccs.neu.edu>
	<F5BFE3BD-7416-4F13-AF7F-0775E3234C92@gmail.com>
	<20100418183759.GA11366@coredump.intra.peff.net>
	<r2wfabb9a1e1004181143o7ebe2cf1t883ee4a12ba29a24@mail.gmail.com>
	<20100418185519.GA14331@coredump.intra.peff.net>
	<19403.26467.273476.220670@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	Steven Michalske <smichalske@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 18 22:53:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3bUa-0000SN-4G
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 22:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab0DRUxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 16:53:19 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:44074 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266Ab0DRUxS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 16:53:18 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O3bUR-0006wo-Uk; Sun, 18 Apr 2010 16:53:15 -0400
In-Reply-To: <19403.26467.273476.220670@winooski.ccs.neu.edu>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145246>

On Apr 18, Eli Barzilay wrote:
> On Apr 18, Jeff King wrote:
> > I think setting init.templatedir or GIT_TEMPLATE_DIR in the
> > environment would accomplish the latter.
> 
> Yes, that sounds like it will work, and I'll do that.

... when 1.7.1 is out.  That's probably enough time for me to make a
mistake.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
