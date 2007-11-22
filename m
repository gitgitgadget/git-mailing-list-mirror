From: David Brown <git@davidb.org>
Subject: Re: Reordering lines in "git-rebase -i" task sheet
Date: Thu, 22 Nov 2007 11:25:56 -0800
Message-ID: <20071122192556.GA14662@old.davidb.org>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:26:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvHgu-0006Db-N7
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 20:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbXKVT0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 14:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbXKVT0E
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 14:26:04 -0500
Received: from mail.davidb.org ([66.93.32.219]:43454 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383AbXKVT0D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 14:26:03 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1IvHgS-0003xQ-T1; Thu, 22 Nov 2007 11:25:56 -0800
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65838>

On Thu, Nov 22, 2007 at 01:21:55AM -0800, Junio C Hamano wrote:

>That is the reason why git commit leaves the first line empty in
>its initial template.  It is to allow the user to immediately
>start typing.

Unless of course your editor tries to be "helpful" and remember what line
you were on previously in a file.

David
