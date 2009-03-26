From: Jeff King <peff@peff.net>
Subject: Re: Question: Is it possible to host a writable git repo over both
	http and ssh?
Date: Wed, 25 Mar 2009 23:36:23 -0400
Message-ID: <20090326033623.GA8031@coredump.intra.peff.net>
References: <49CA6A17.6050903@gmail.com> <20090326021259.GA5835@coredump.intra.peff.net> <49CAF607.1020905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 04:38:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmgQk-0005is-RE
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 04:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbZCZDgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 23:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbZCZDgg
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 23:36:36 -0400
Received: from peff.net ([208.65.91.99]:56530 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbZCZDgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 23:36:35 -0400
Received: (qmail 11692 invoked by uid 107); 26 Mar 2009 03:36:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 23:36:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 23:36:23 -0400
Content-Disposition: inline
In-Reply-To: <49CAF607.1020905@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114716>

On Wed, Mar 25, 2009 at 10:27:03PM -0500, Mike Gaffney wrote:

> Does this go for JGit as well?

The hook must be enabled on the server side; are you running JGit on the
server, or regular git?

-Peff
