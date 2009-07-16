From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Thu, 16 Jul 2009 16:19:40 -0400
Message-ID: <4A5F8B5C.3020902@garzik.org>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org> <4A5EA598.5050801@garzik.org> <7v3a8xb0lz.fsf@alter.siamese.dyndns.org> <4A5ECC09.3010405@garzik.org> <7vocrl9kwi.fsf@alter.siamese.dyndns.org> <4A5ED38F.5070708@garzik.org> <7v4otd9jg8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933296AbZGPUVY@vger.kernel.org Thu Jul 16 22:21:47 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933296AbZGPUVY@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRXSc-0008UQ-DS
	for glk-linux-kernel-3@gmane.org; Thu, 16 Jul 2009 22:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933296AbZGPUVY (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 16 Jul 2009 16:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933275AbZGPUVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jul 2009 16:21:24 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:58424 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933248AbZGPUVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jul 2009 16:21:23 -0400
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=bd.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1MRXSD-00023R-Kn; Thu, 16 Jul 2009 20:21:22 +0000
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7v4otd9jg8.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123418>

Junio C Hamano wrote:
> Jeff Garzik <jeff@garzik.org> writes:
> 
>> That direction doesn't work due to firewalls, hence the scp out /to/
>> remote.example.com.
> 
> Ah, then the "git init --bare" at remote followed by pushing -all into it,
> suggested in your other subthread, would be an appropriate way.

Thanks!

	Jeff
