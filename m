From: Jeff King <peff@peff.net>
Subject: Re: git push should automatically push to remote tracking branch
Date: Mon, 19 Oct 2009 01:06:27 -0400
Message-ID: <20091019050627.GA16255@coredump.intra.peff.net>
References: <ee22b09e0910181320j15a273e8vc510801c890b93a9@mail.gmail.com>
 <1B59440B-5929-4AB9-82C7-05188DC4F959@dbservice.com>
 <ee22b09e0910182050k55efac83v6799285d992fcbb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org
To: Mohit Aron <mohit.aron@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 07:06:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzkS5-00076C-91
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 07:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbZJSFG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 01:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbZJSFG0
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 01:06:26 -0400
Received: from peff.net ([208.65.91.99]:49419 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbZJSFGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 01:06:25 -0400
Received: (qmail 14560 invoked by uid 107); 19 Oct 2009 05:10:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 19 Oct 2009 01:10:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Oct 2009 01:06:27 -0400
Content-Disposition: inline
In-Reply-To: <ee22b09e0910182050k55efac83v6799285d992fcbb0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130650>

On Sun, Oct 18, 2009 at 08:50:57PM -0700, Mohit Aron wrote:

> Thanks - I suppose this is a new config option. I'm running Git
> version 1.6.0.4 (the latest with Ubuntu Jaunty) and that doesn't seem
> to have this option.

Yes, it was added in v1.6.3.

-Peff
