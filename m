From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to access working tree from .git dir?
Date: Fri, 07 Sep 2007 15:12:54 -0700
Message-ID: <7vveam15w9.fsf@gitster.siamese.dyndns.org>
References: <1189120800.6203.23.camel@beauty>
	<7v642m436q.fsf@gitster.siamese.dyndns.org>
	<1189200421.12525.8.camel@beauty>
	<7vhcm62lru.fsf@gitster.siamese.dyndns.org>
	<1189203064.15140.2.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Josh England <jjengla@comcast.net>
X-From: git-owner@vger.kernel.org Sat Sep 08 00:13:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITm4u-00076x-BR
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 00:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758592AbXIGWNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 18:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758626AbXIGWNV
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 18:13:21 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758590AbXIGWNV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 18:13:21 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A71913044B;
	Fri,  7 Sep 2007 18:13:18 -0400 (EDT)
In-Reply-To: <1189203064.15140.2.camel@beauty> (Josh England's message of
	"Fri, 07 Sep 2007 16:11:04 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58085>

Josh England <jjengla@comcast.net> writes:

> OK. Fair enough.  Maybe it would be good to note in git-sh-setup.sh that
> many of the supplied functions will not work when called from within
> $GIT_DIR.

Sorry, "supplied functions"?  Care to clarify with a patch?
