From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] git-send-email: Add AUTH LOGIN support
Date: Fri, 19 Aug 2011 16:24:40 -0700
Message-ID: <1313796280.11178.25.camel@Joe-Laptop>
References: <c1be0c3bd05779897fdc92907fe65d84c88ac72b.1312591104.git.joe@perches.com>
	 <7vzkjn16n6.fsf@alter.siamese.dyndns.org>
	 <1312608114.6419.18.camel@Joe-Laptop> <1313716585.11178.2.camel@Joe-Laptop>
	 <7v1uwh0zj4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Graham Barr <gbarr@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 01:26:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuYSY-0007TW-AU
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 01:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab1HSXYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 19:24:44 -0400
Received: from wondertoys-mx.wondertoys.net ([206.117.179.246]:43330 "EHLO
	labridge.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750760Ab1HSXYo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 19:24:44 -0400
Received: from [173.60.85.8] (account joe@perches.com HELO [192.168.1.156])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 18039492; Fri, 19 Aug 2011 16:24:42 -0700
In-Reply-To: <7v1uwh0zj4.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179745>

On Fri, 2011-08-19 at 16:09 -0700, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> > I think my patch should be applied until Net::SMTP is updated.
> And you already have applied to your copy, no?

True.

> I do not necessarily agree with you that the patch _should_
> be applied to my tree.

Your choice.  It does make tracking git development
a bit of a pain for me though.

There doesn't seem to be anything like a patchwork queue
for git development to check status of patches.

I've sent a couple of other patches to git-send-email.

http://marc.info/?l=git&m=131190328311281&w=2
http://marc.info/?l=git&m=131131975804893&w=2

Any comments or plans to ack/nack those?
