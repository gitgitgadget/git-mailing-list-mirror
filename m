From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Add "git grep" functionality in a grep-style compilation buffer
Date: Tue, 09 Sep 2008 11:25:06 +0200
Message-ID: <871vzt8ydp.fsf@lysator.liu.se>
References: <1220122523-68561-1-git-send-email-david@endpoint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: julliard@winehq.org, David Christensen <david@endpoint.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 11:26:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KczUG-0004HN-M9
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 11:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbYIIJZJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Sep 2008 05:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbYIIJZJ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 05:25:09 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:51165 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbYIIJZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 05:25:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A76AD201026A;
	Tue,  9 Sep 2008 11:25:06 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30508-01-26; Tue, 9 Sep 2008 11:25:06 +0200 (CEST)
Received: from krank (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 62DDA200A255;
	Tue,  9 Sep 2008 11:25:06 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 28C637B4089; Tue,  9 Sep 2008 11:25:06 +0200 (CEST)
In-Reply-To: <1220122523-68561-1-git-send-email-david@endpoint.com> (David Christensen's message of "Sat\, 30 Aug 2008 13\:55\:23 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95364>

David Christensen <david@endpoint.com> writes:

> Signed-off-by: David Christensen <david@endpoint.com>

I posted a longer version of git-grep that built on the grep commands
in Emacs 22 a while ago. It gives you a better was to navigate to the
hits etc. I'll dig it up again.

--=20
David K=C3=A5gedal
