From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: Re: [RFC][PATCH] Print the usage string on stdout instead of stderr.
Date: Mon, 17 May 2010 16:07:44 +0200
Message-ID: <87hbm6tydr.fsf@thor.thematica.it>
References: <878w7ieu4p.fsf@thor.thematica.it>
	<4BF12C96.9030802@drmicha.warpmail.net>
	<buofx1qhgum.fsf@dhlpc061.dev.necel.com>
	<4BF14500.30806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 17 16:07:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE0yD-0007Wb-Ae
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 16:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab0EQOGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 10:06:55 -0400
Received: from chapters.gnu.org ([91.121.9.110]:49944 "EHLO chapters.gnu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab0EQOGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 10:06:54 -0400
Received: by chapters.gnu.org (Postfix, from userid 111)
	id 8CD4A46D166; Mon, 17 May 2010 16:06:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on chapters.gnu.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
X-Spam-Level-GNUchapters: 
Received: from thor.thematica.it (localhost.localdomain [127.0.0.1])
	by chapters.gnu.org (Postfix) with ESMTP id 036AF46D165;
	Mon, 17 May 2010 16:06:50 +0200 (CEST)
In-Reply-To: <4BF14500.30806@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 17 May 2010 15:30:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147238>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Well sure it is, just as I wrote. So do you suggest that the file handle
> should depend on the use case? Care to implement?

Thanks for your comments.  I will fix my patch accordingly and resend it.

Cheers,
Giuseppe
