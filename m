From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2009, #06; Wed, 25)
Date: Fri, 27 Nov 2009 01:59:04 -0500
Message-ID: <20091127065904.GE20844@coredump.intra.peff.net>
References: <7v8wduksgq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 07:59:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDunM-0004fH-03
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 07:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbZK0G65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 01:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbZK0G65
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 01:58:57 -0500
Received: from peff.net ([208.65.91.99]:53842 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbZK0G64 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 01:58:56 -0500
Received: (qmail 25149 invoked by uid 107); 27 Nov 2009 07:03:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Nov 2009 02:03:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Nov 2009 01:59:04 -0500
Content-Disposition: inline
In-Reply-To: <7v8wduksgq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133864>

On Wed, Nov 25, 2009 at 05:03:33PM -0800, Junio C Hamano wrote:

> * jc/grep-full-tree (2009-11-24) 1 commit.
>  - grep: --full-tree
> 
> We probably would want test, doc and a configuration variable to make it
> default (or non-default) before we can merge it to 'master'.

I can try to pick this up. But did we reach a decision on having a
configuration variable?

-Peff
