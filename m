From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2010, #06; Tue, 23)
Date: Wed, 24 Feb 2010 01:28:51 -0500
Message-ID: <20100224062850.GA12796@coredump.intra.peff.net>
References: <7v635nsa37.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 07:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkAjy-0002ND-K9
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 07:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733Ab0BXG2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 01:28:54 -0500
Received: from peff.net ([208.65.91.99]:36575 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123Ab0BXG2x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 01:28:53 -0500
Received: (qmail 29914 invoked by uid 107); 24 Feb 2010 06:29:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 24 Feb 2010 01:29:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2010 01:28:51 -0500
Content-Disposition: inline
In-Reply-To: <7v635nsa37.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140903>

On Tue, Feb 23, 2010 at 05:20:44PM -0800, Junio C Hamano wrote:

> * cw/test-lib-relicense (2010-02-22) 1 commit
>  . test-lib.sh: Add explicit license detail, with change from GPLv2 to GPLv2+.
> 
> I think a reasonable way forward would be to collect Acks from
> everybody who appears on "git blame" or "git shortlog" output.

Somehow I am number 4 on "git shortlog -ns" for test-lib.sh, despite
having contributed only a tiny number of lines. :)  But certainly I am
fine with re-licensing it.

> How do people feel about relicensing the whole (except for the
> obviously borrowed bits, such as xdiff/) under GPLv2 _or later_?  I am
> not a big fan of GPLv3 and do not see a compelling reason to switch to
> v3 for the sake of v3 license per-se, but helping others that want to
> use our code might tip the balance.

I have no problem with re-licensing my contributions.

-Peff
