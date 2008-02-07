From: bdowning@lavos.net (Brian Downing)
Subject: Re: Applying patches from gmane can be dangerous.
Date: Thu, 7 Feb 2008 07:32:08 -0600
Message-ID: <20080207133208.GT26392@lavos.net>
References: <20080205211044.GP26392@lavos.net> <7vodatqu6w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Magne Ingebrigtsen <larsi+gmane@gnus.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 14:33:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN6s6-0003Vh-5K
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 14:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238AbYBGNcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 08:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756819AbYBGNcN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 08:32:13 -0500
Received: from mxsf05.insightbb.com ([74.128.0.75]:36084 "EHLO
	mxsf05.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759470AbYBGNcM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 08:32:12 -0500
X-IronPort-AV: E=Sophos;i="4.25,316,1199682000"; 
   d="scan'208";a="222520431"
Received: from unknown (HELO asav00.insightbb.com) ([172.31.249.124])
  by mxsf05.insightbb.com with ESMTP; 07 Feb 2008 08:32:08 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAJeXqkdKhvkY/2dsb2JhbACBWZAsmks
X-IronPort-AV: E=Sophos;i="4.25,316,1199682000"; 
   d="scan'208";a="154145910"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav00.insightbb.com with ESMTP; 07 Feb 2008 08:32:09 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 9131E309F21; Thu,  7 Feb 2008 07:32:08 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <7vodatqu6w.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72943>

On Wed, Feb 06, 2008 at 08:14:31PM -0800, Junio C Hamano wrote:
> This is really sad.  gmane gives us a clean threaded interface
> (both in web and newsreader), and it never forgets. Whenever I
> need to refer somebody to an old discussion, I can give an URL
> to it and allmost all the discussion messages are there with a
> single paste and clicking around.  It has been an indispensable
> service to me ever since I started reading the git list with it.
> It is really a shame that I have to prevent picking up patch
> messages from it with the above hook.
> 
> I am wondering if other development communities had a similar
> issue already, and if so how they are dealing with it.

Gmane didn't start doing this until recently.  Maybe they can stop it on
a group-by-group basis?  Every post to git@vger is archived elsewhere
with unmangled email addresses anyway...

"We understand why you're doing this, but it hurts us greatly.  Please
stop."

-bcd
