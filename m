From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie patch question
Date: Thu, 06 Aug 2009 12:24:48 -0700
Message-ID: <7vr5vokanz.fsf@alter.siamese.dyndns.org>
References: <396c099f0908060554i34dc74dfubcfec89735a98833@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 21:25:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ8aE-0006mr-Sq
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 21:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524AbZHFTYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 15:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756521AbZHFTYx
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 15:24:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515AbZHFTYx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 15:24:53 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89C441F532;
	Thu,  6 Aug 2009 15:24:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5BFD61F52F; Thu,  6 Aug 2009
 15:24:50 -0400 (EDT)
In-Reply-To: <396c099f0908060554i34dc74dfubcfec89735a98833@mail.gmail.com>
 (Luke Diamand's message of "Thu\, 6 Aug 2009 13\:54\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D141EB12-82BE-11DE-A075-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125110>

Luke Diamand <luke@diamand.org> writes:

> I submitted a patch a while back to speed up git-p4. What steps should
> I take next to move it on? Did I submit the patch wrong in the first
> place?
>
> http://thread.gmane.org/gmane.comp.version-control.git/124410

You didn't do anything wrong at all.  I still have the patch in my Inbox.

I was waiting to see an Ack, independent success reports and such.  As I
do not interract with p4 myself at all, I wouldn't be able to judge
patches to p4 area (and contrib/ in general) without help from others.
