From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow selection of different cleanup modes for commit messages
Date: Fri, 21 Dec 2007 13:43:49 -0800
Message-ID: <7v8x3n4tbe.fsf@gitster.siamese.dyndns.org>
References: <20071220211835.GA3052@steel.home>
	<alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org>
	<7vlk7plydv.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0712201555570.21557@woody.linux-foundation.org>
	<20071221173521.GA3494@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 22:44:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5pfK-0004x6-US
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 22:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040AbXLUVoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 16:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754947AbXLUVoA
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 16:44:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbXLUVn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 16:43:59 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F7035C97;
	Fri, 21 Dec 2007 16:43:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 361A15C95;
	Fri, 21 Dec 2007 16:43:51 -0500 (EST)
In-Reply-To: <20071221173521.GA3494@steel.home> (Alex Riesen's message of
	"Fri, 21 Dec 2007 18:35:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69097>

Alex Riesen <raa.lkml@gmail.com> writes:

> The patch is on top of my previos patches. Junio, if you wish, I can
> squash and resend.

That would be a sane thing to do.
