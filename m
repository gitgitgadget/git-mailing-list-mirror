From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] add -p: warn if only binary changes present
Date: Sun, 26 Oct 2008 15:38:01 -0400
Message-ID: <20081026193801.GA1105@coredump.intra.peff.net>
References: <20081026104006.GA18969@neumann> <1225049826-14941-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	szeder@ira.uka.de
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 26 20:39:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuBSQ-0000rx-J3
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 20:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbYJZTiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 15:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753749AbYJZTiH
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 15:38:07 -0400
Received: from peff.net ([208.65.91.99]:4703 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753682AbYJZTiG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 15:38:06 -0400
Received: (qmail 9088 invoked by uid 111); 26 Oct 2008 19:38:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 26 Oct 2008 15:38:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2008 15:38:01 -0400
Content-Disposition: inline
In-Reply-To: <1225049826-14941-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99181>

On Sun, Oct 26, 2008 at 08:37:06PM +0100, Thomas Rast wrote:

> > What about
> > 
> >    Only binary files changed.
> > 
> > or something of the sort?
> 
> Yes, why not.

That is better, IMHO.

-Peff
