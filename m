From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] best way to show diff of commit
Date: Sun, 25 Nov 2007 14:27:09 -0800
Message-ID: <7vfxyuj70i.fsf@gitster.siamese.dyndns.org>
References: <20071125211831.GA21121@artemis.corp>
	<20071125212748.GB23820@fieldses.org>
	<20071125220902.GB21121@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 25 23:27:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwPwu-0007D3-Jb
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 23:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbXKYW1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 17:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754508AbXKYW1T
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 17:27:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55096 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbXKYW1R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 17:27:17 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AA4602F0;
	Sun, 25 Nov 2007 17:27:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id AE0DD99B1A;
	Sun, 25 Nov 2007 17:27:33 -0500 (EST)
In-Reply-To: <20071125220902.GB21121@artemis.corp> (Pierre Habouzit's message
	of "Sun, 25 Nov 2007 23:09:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66018>

Pierre Habouzit <madcoder@debian.org> writes:

>   Hmm it doesn't because I would have to call git commit -v each time I
> commit and well I _like_ having the status better. And moreover I want
> the diff to go in a separated buffer too.

I've never felt it a problem while editing the log message in Emacs.

Don't enhanced vi implementations let you split the same buffer into
two allowing you to view different portions of it these days?
