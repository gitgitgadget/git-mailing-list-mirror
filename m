From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: Need your help with MinGW Issue 17: --color options don't work (produce garbage)
Date: Wed, 15 Aug 2007 14:34:56 -0700
Message-ID: <7vsl6ko51b.fsf@gitster.siamese.dyndns.org>
References: <a1bbc6950708142329w4e0e3d7cq573c67dd3b28f03a@mail.gmail.com>
	<3f4fd2640708150032l7441b285mc2cc9e22702bce21@mail.gmail.com>
	<Pine.LNX.4.64.0708151708570.19222@wbgn129.biozentrum.uni-wuerzburg.de>
	<46C36E7C.1080501@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Reece Dunn <msclrhd@googlemail.com>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Wed Aug 15 23:35:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILQWE-0007o3-5M
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 23:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbXHOVfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 17:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbXHOVfF
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 17:35:05 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:45546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796AbXHOVfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 17:35:03 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C282C11FD26;
	Wed, 15 Aug 2007 17:35:19 -0400 (EDT)
In-Reply-To: <46C36E7C.1080501@dawes.za.net> (Rogan Dawes's message of "Wed,
	15 Aug 2007 23:22:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55952>

Rogan Dawes <lists@dawes.za.net> writes:

> Users that *do* need to use rxvt or SSH should simply disable the
> color mode, or alternatively, use the cygwin version. Color, while
> useful, is hardly critical functionality.

Heh, that almost suggests that the native Windows command.com
support can disable the color without upsetting anybody ;-)
