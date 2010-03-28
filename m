From: Lars Damerow <lars@pixar.com>
Subject: Re: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Sun, 28 Mar 2010 10:32:25 -0700
Message-ID: <20100328173225.GA2397@pixar.com>
References: <1268855753-25840-1-git-send-email-lars@pixar.com> <1268855753-25840-4-git-send-email-lars@pixar.com> <20100328092253.GA17563@coredump.intra.peff.net> <7vr5n44crq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 19:42:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvwUy-0006UY-Pb
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 19:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab0C1RmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 13:42:01 -0400
Received: from nmx.pixar.com ([199.108.77.23]:9585 "EHLO nmx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754817Ab0C1RmA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 13:42:00 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Mar 2010 13:42:00 EDT
X-PixarMID: 2153974
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.152
X-IronPort-AV: E=Sophos;i="4.51,323,1267430400"; 
   d="scan'208,223";a="2153974"
Received: from helper.dynamic.pixar.com ([138.72.131.152])
  by nimbus.pixar.com with ESMTP; 28 Mar 2010 10:32:29 -0700
Received: from helper.dynamic.pixar.com (localhost [127.0.0.1])
	by helper.dynamic.pixar.com (8.14.3/8.14.3) with ESMTP id o2SHWPEk002417;
	Sun, 28 Mar 2010 10:32:28 -0700
Received: (from lars@localhost)
	by helper.dynamic.pixar.com (8.14.3/8.14.3/Submit) id o2SHWPJK002414;
	Sun, 28 Mar 2010 10:32:25 -0700
Content-Disposition: inline
In-Reply-To: <7vr5n44crq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143408>

>From Junio C Hamano <gitster@pobox.com>, Sun, Mar 28, 2010 at 09:44:09AM -0700:
> Jeff King <peff@peff.net> writes:
> 
> > With those fixes, I think it should be ready for 'next'.
> 
> Yeah, looks nice; thanks both.

Thanks all for the suggestions! Jeff, shall I just squash in the doc
patch you sent and resubmit the patches to the list?

-lars

--
lars r. damerow :: button pusher :: pixar animation studios
