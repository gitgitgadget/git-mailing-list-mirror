From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: Is there something like a blamed diff?
Date: Mon, 17 Feb 2014 11:24:04 +0100
Message-ID: <87ioseujej.fsf@thomasrast.ch>
References: <8738jk1as7.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 17 11:24:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFLN6-000280-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 11:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbaBQKYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 05:24:16 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:51962 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbaBQKYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 05:24:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id B87DB4D6594;
	Mon, 17 Feb 2014 11:24:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cxtFW2U5sgzG; Mon, 17 Feb 2014 11:24:04 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (80-219-153-229.dclient.hispeed.ch [80.219.153.229])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 970934D64BD;
	Mon, 17 Feb 2014 11:24:04 +0100 (CET)
In-Reply-To: <8738jk1as7.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Sat, 15 Feb 2014 19:38:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242251>

David Kastrup <dak@gnu.org> writes:

> When comparing two branches, decorating the flat diff with the
> respectively responsible commits seems like it would be nice to do/have
> (the blame on the identical parts, in contrast, is not really
> interesting).  Is there any tool that provides something like that?

This seems to come up every year or so:

http://thread.gmane.org/gmane.comp.version-control.git/110369/focus=110383

-- 
Thomas Rast
tr@thomasrast.ch
