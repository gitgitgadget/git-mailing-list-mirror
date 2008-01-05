From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-walkthrough-add script
Date: Fri, 04 Jan 2008 18:55:41 -0800
Message-ID: <7vlk75f0b6.fsf@gitster.siamese.dyndns.org>
References: <1199426431-sup-6092@south>
	<20080104072650.GA24685@coredump.intra.peff.net>
	<1199471454-sup-4786@south>
	<20080104210751.GB26248@coredump.intra.peff.net>
	<1199500441-sup-4067@south>
	<7vprwhf0kf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: William Morgan <wmorgan-git@masanjin.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 03:56:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAzCx-00036P-AZ
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 03:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbYAECz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 21:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbYAECz5
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 21:55:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484AbYAECz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 21:55:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0017251CF;
	Fri,  4 Jan 2008 21:55:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C48051CE;
	Fri,  4 Jan 2008 21:55:48 -0500 (EST)
In-Reply-To: <7vprwhf0kf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 04 Jan 2008 18:50:08 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69633>

Junio C Hamano <gitster@pobox.com> writes:

> William Morgan <wmorgan-git@masanjin.net> writes:
>
>> Not to show off my git newbness any more than necessary, but when I run
>> both git-add -i and git-add -p, I see exactly the same output and
>> interface. Are they meant to be different?
>
> They are meant to be different.
> ...
> There may be something broken with your git installation.

A shot in the dark.  Do you have more than one installation of
git, one of which is ancient and whose git-add--interactive does
not even have --patch option?
