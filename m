From: Nick <oinksocket@letterboxes.org>
Subject: Re: Directory replaced with a file confuses cherry-pick
Date: Fri, 18 Feb 2011 15:30:05 +0000
Message-ID: <4D5E907D.2090808@letterboxes.org>
References: <op.vq3qtqtj56e9f9@xman.eng.oslo.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexey Feldgendler <alexeyf@opera.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 17:09:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqStn-0000dD-Th
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 17:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757297Ab1BRQJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 11:09:25 -0500
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:37868 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757274Ab1BRQJX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 11:09:23 -0500
X-Greylist: delayed 2473 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Feb 2011 11:09:23 EST
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.102])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <oinksocket@letterboxes.org>)
	id 1PqSFd-0006Kh-DZ; Fri, 18 Feb 2011 15:28:09 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <op.vq3qtqtj56e9f9@xman.eng.oslo.osa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167220>

On 18/02/11 14:06, Alexey Feldgendler wrote:
> I think I've found a bug. Here is how to reproduce.

It looks like one I found in 1.7.0.4 - for which Elijah Newren submitted some
patches, although I don't happen to know what their current status is.

  http://comments.gmane.org/gmane.comp.version-control.git/155147

N
