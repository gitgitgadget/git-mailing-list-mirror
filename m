From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Export some email and pretty-printing functions
Date: Wed, 06 Feb 2008 12:30:30 -0800
Message-ID: <7vabmdx1y1.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802061141140.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:31:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqvQ-0003Eh-SG
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759549AbYBFUak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755663AbYBFUaj
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:30:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759549AbYBFUai (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:30:38 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 232602E47;
	Wed,  6 Feb 2008 15:30:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AF2232E46;
	Wed,  6 Feb 2008 15:30:33 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72844>

Daniel Barkalow <barkalow@iabervon.org> writes:

> These will be used for generating the cover letter in addition to the
> patch emails.

Nicely done.  The only potential issue I see is add_user_info()
as a global name may be a bit too generic.
