From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (try 3)] http.c: 'use_git_config_string' on configuration
 options.
Date: Sun, 20 Apr 2008 09:26:08 -0700
Message-ID: <7viqyccx27.fsf@gitster.siamese.dyndns.org>
References: <480A7499.1040705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tordek <kedrot@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 18:27:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JncNe-0003eS-Lf
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 18:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbYDTQ0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 12:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbYDTQ0V
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 12:26:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbYDTQ0U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 12:26:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D8446C59;
	Sun, 20 Apr 2008 12:26:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C91426C58; Sun, 20 Apr 2008 12:26:10 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79965>

Tordek <kedrot@gmail.com> writes:

> Signed-off-by: Guillermo O. Freschi <tordek@tordek.com.ar>
> ---
> My apologies, I had made a mistake on the previous attempt.

Please make up your mind as to who you want to claim to be.

Are you "Tordek <kedrot@gmail.com>" without first-last name, or are you
"Guillermo O Freschi <tordek@tordek.com.ar>"?

I suspect the latter, but in that case, it is easier for me if you add an
extra From: header at the top of the message.  In other words, do this:

(The mail header, RFC 2822)
	From: Tordek <kedrot@gmail.com>
	Subject: [PATCH] http.c: use git_config_string() for parsing
	Date: .....

(The mail body)
	From: Guillermo O. Freschi <tordek@tordek.com.ar>

	<<explain what the patch does here>>

	Signed-off-by: Guillermo O. Freschi <tordek@tordek.com.ar>
	---
	<<commentary, if any>>
	 <<diffstat>>
	 <<diff>>
