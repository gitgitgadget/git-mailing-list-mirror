From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-filter-branch.txt: Fix description of
 --commit-filter
Date: Fri, 30 May 2008 18:48:58 -0700
Message-ID: <7v1w3jgs51.fsf@gitster.siamese.dyndns.org>
References: <1212183820-40712-1-git-send-email-kevin@sb.org>
 <7vlk1rh0av.fsf@gitster.siamese.dyndns.org>
 <98EEBDF4-9964-4CA6-ABBD-DB72C4F6CAD3@sb.org>
 <7v63svgy0q.fsf@gitster.siamese.dyndns.org>
 <AF9CB160-FFC9-4372-BE86-5FAC6B59A050@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat May 31 03:50:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2GEn-0007Ql-6X
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 03:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbYEaBtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 21:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbYEaBtH
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 21:49:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYEaBtH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 21:49:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 185C236A9;
	Fri, 30 May 2008 21:49:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8874736A8; Fri, 30 May 2008 21:49:00 -0400 (EDT)
In-Reply-To: <AF9CB160-FFC9-4372-BE86-5FAC6B59A050@sb.org> (Kevin Ballard's
 message of "Fri, 30 May 2008 17:33:02 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF158F1C-2EB3-11DD-ADC7-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83363>

Kevin Ballard <kevin@sb.org> writes:

> You're still talking about the parent-filter here. I think you're
> quite confused.

Blush.  I should go to bed.
