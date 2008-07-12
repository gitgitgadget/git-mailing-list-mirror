From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 FIXED] help (Windows): Display HTML in default
 browser using Windows' shell API
Date: Sat, 12 Jul 2008 00:07:31 -0700
Message-ID: <7vskufy40c.fsf@gitster.siamese.dyndns.org>
References: <228FC26D-D318-487A-9BF3-B473096CB0C9@zib.de>
 <1215761822-21356-1-git-send-email-prohaska@zib.de>
 <7vtzevhjf8.fsf@gitster.siamese.dyndns.org>
 <8D150442-8B57-4025-9110-BC4C23C2310C@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 09:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHZE7-00028c-T8
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 09:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbYGLHHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 03:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754188AbYGLHHl
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 03:07:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbYGLHHk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 03:07:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 559372851F;
	Sat, 12 Jul 2008 03:07:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B692E2851C; Sat, 12 Jul 2008 03:07:33 -0400 (EDT)
In-Reply-To: <8D150442-8B57-4025-9110-BC4C23C2310C@zib.de> (Steffen
 Prohaska's message of "Sat, 12 Jul 2008 08:45:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 369A1280-4FE1-11DD-9F27-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88223>

Steffen Prohaska <prohaska@zib.de> writes:

>> Do you mean to have that printf() or is it a leftover debugging
>> statement?
>
> I mean to have it.

Ok, I was just checking.  Unless other Windows users complain, will apply
as-is.  As you might guess, I am completely neutral on this one.
