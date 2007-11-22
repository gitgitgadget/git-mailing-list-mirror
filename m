From: Jeff King <peff@peff.net>
Subject: Re: Addendum to "MaintNotes"
Date: Thu, 22 Nov 2007 05:36:00 -0500
Message-ID: <20071122103600.GA10389@sigill.intra.peff.net>
References: <46dff0320711210511g7d9febf5k47b082cc13bb905a@mail.gmail.com> <7vhcjf9l1k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ping Yin <pkufranky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 11:36:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9Py-00020J-Jm
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbXKVKgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 05:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbXKVKgE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:36:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1791 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbXKVKgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 05:36:03 -0500
Received: (qmail 21787 invoked by uid 111); 22 Nov 2007 10:36:00 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 05:36:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 05:36:00 -0500
Content-Disposition: inline
In-Reply-To: <7vhcjf9l1k.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65774>

Thanks for writing this, Junio. It is always interesting to see git
workflows discussed in detail, and yours is more interesting than most.

On Wed, Nov 21, 2007 at 04:32:55PM -0800, Junio C Hamano wrote:

>    - Obviously correct fixes that pertain to the tip of 'master'
>      are directly applied to 'master'.
> 
>    This step is done with "git am".
> 
>      $ git checkout maint    ;# or "git checkout maint"

One of those "maints" should probably be "master".

-Peff
