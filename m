From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Including branch info in git format-patch
Date: Thu, 19 Jun 2008 14:41:54 -0700
Message-ID: <7vod5xrtjx.fsf@gitster.siamese.dyndns.org>
References: <20080619154251.GA16475@jurassic>
 <20080619202843.GA6207@sigill.intra.peff.net>
 <7vskv9rvrc.fsf@gitster.siamese.dyndns.org> <20080619212626.GA29643@jurassic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Mukund Sivaraman <muks@banu.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:43:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Rui-0005eT-GV
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbYFSVmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752961AbYFSVmT
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:42:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbYFSVmS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 17:42:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CE161C7D1;
	Thu, 19 Jun 2008 17:42:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ACE6B1C7CD; Thu, 19 Jun 2008 17:42:02 -0400 (EDT)
In-Reply-To: <20080619212626.GA29643@jurassic> (Mukund Sivaraman's message of
 "Fri, 20 Jun 2008 02:56:27 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9214F2BA-3E48-11DD-99E8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85538>

Mukund Sivaraman <muks@banu.com> writes:

> My problem is that I can't send a patch out to the list for other
> developers to try, without some annotation for them, of which branch to
> try it on.

So what's wrong telling that when you send out the patch, between the time
you run format-patch and send-email?
