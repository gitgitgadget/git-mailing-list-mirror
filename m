From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ship sample hooks with .sample suffix
Date: Wed, 25 Jun 2008 01:09:10 -0700
Message-ID: <7v4p7i3pi1.fsf@gitster.siamese.dyndns.org>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
 <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
 <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com>
 <7v3an2bh3b.fsf@gitster.siamese.dyndns.org>
 <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com>
 <7v4p7i9ygd.fsf@gitster.siamese.dyndns.org>
 <7vtzfi8dvk.fsf_-_@gitster.siamese.dyndns.org>
 <7vod5q8c25.fsf@gitster.siamese.dyndns.org>
 <1214376700.4861eafc43b36@webmail.eunet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Jun 25 10:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBQ56-0005yd-MC
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 10:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbYFYIJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 04:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYFYIJY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 04:09:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbYFYIJX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 04:09:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E817117DF0;
	Wed, 25 Jun 2008 04:09:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2717B17DE7; Wed, 25 Jun 2008 04:09:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0481C0D2-428E-11DD-9D99-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86252>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> I am very confident in the series as far as using it on Windows is concerned.
> But I must admit that I have started to use it on Linux only recently.
> Therefore, cooking it in 'next' for a few days is probably not a mistake.

The question obviously was about using outside Windows context as we have
been talking about merging it into my history ;-)

I'll push out the master with the *.sample patch hopefully soon.
