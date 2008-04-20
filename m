From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (try 3)] http.c: 'use_git_config_string' on configuration
 options.
Date: Sat, 19 Apr 2008 20:30:59 -0700
Message-ID: <7vwsmtdwy4.fsf@gitster.siamese.dyndns.org>
References: <480A7499.1040705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Tordek <kedrot@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 05:32:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnQHX-0006ik-N9
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 05:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbYDTDbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 23:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbYDTDbO
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 23:31:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbYDTDbN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 23:31:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D0016225;
	Sat, 19 Apr 2008 23:31:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8CC0C6222; Sat, 19 Apr 2008 23:31:07 -0400 (EDT)
In-Reply-To: <480A7499.1040705@gmail.com> (kedrot@gmail.com's message of
 "Sat, 19 Apr 2008 19:39:21 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79946>

Tordek <kedrot@gmail.com> writes:

> Signed-off-by: Guillermo O. Freschi <tordek@tordek.com.ar>
> ---
> My apologies, I had made a mistake on the previous attempt.

Heh, Christian, doesn't this patch look _suspiciously_ familiar ;-)?

cf.

 $gmane/79392 aka Message-Id: <7vskxqe0db.fsf@gitster.siamese.dyndns.org>
