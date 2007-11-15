From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: [PATCH] Fix "identifier redeclared" compilation error with SUN
 cc.
Date: Thu, 15 Nov 2007 23:28:52 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711152323510.7501@bianca.dialin.t-online.de>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
 <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
 <Pine.LNX.4.64.0711152253430.4090@bianca.dialin.t-online.de>
 <7v640340kp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	raa.lkml@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 23:29:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsnD1-0002yW-G8
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 23:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbXKOW26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 17:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbXKOW26
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 17:28:58 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56147 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932324AbXKOW25 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 17:28:57 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4B243479A9;
	Thu, 15 Nov 2007 17:28:57 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 15 Nov 2007 17:28:57 -0500
X-Sasl-enc: O0hoxNvHahA5oHiKIFNpbCWqldhR4NbJJlDyhmzjMtlb 1195165736
Received: from [192.168.2.101] (p549A10B1.dip0.t-ipconnect.de [84.154.16.177])
	by mail.messagingengine.com (Postfix) with ESMTP id EC2B52A57E;
	Thu, 15 Nov 2007 17:28:55 -0500 (EST)
In-Reply-To: <7v640340kp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65177>

On Thu, 15 Nov 2007, Junio C Hamano wrote:
> Are there problems with the implementation in compat/ directory, we ship 
> specifically to help platforms without mkdtemp()?

The Git version that I used for testing at office did not yet include your 
compat fix or did not activate it automatically.

I shall check this out tomorrow and let you know. Sorry, it's already late 
here in Germany (23:27h) - I need to get some sleep ;-)

Regards

Guido
