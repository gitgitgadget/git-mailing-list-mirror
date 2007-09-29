From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Make for-each-ref's grab_date() support per-atom formatting
Date: Sat, 29 Sep 2007 01:17:18 -0700
Message-ID: <7v641tnawh.fsf@gitster.siamese.dyndns.org>
References: <200709281516.05438.andyparkins@gmail.com>
	<200709281517.45133.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 10:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbXW1-0007Ct-4Y
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 10:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbXI2IRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 04:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbXI2IRZ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 04:17:25 -0400
Received: from rune.pobox.com ([208.210.124.79]:57554 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbXI2IRY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 04:17:24 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 58DA913D177;
	Sat, 29 Sep 2007 04:17:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D30E513BC79;
	Sat, 29 Sep 2007 04:17:42 -0400 (EDT)
In-Reply-To: <200709281517.45133.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 28 Sep 2007 15:17:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59447>

I squashed 1+2 together so there is no need to resend.  It would
be nice to see a few tests in the test suite though.
