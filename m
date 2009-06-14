From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: fuggedabadit
Date: Sun, 14 Jun 2009 09:07:30 +0200
Message-ID: <adf1fd3d0906140007y6deac748i7f75e65f70e230a3@mail.gmail.com>
References: <S1750942AbZFNEso/20090614044844Z+270@vger.kernel.org>
	 <4A3481CD.7050602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Phlip <phlip2005@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 09:08:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFjpn-0001zQ-75
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 09:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbZFNHHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 03:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbZFNHHb
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 03:07:31 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42881 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbZFNHHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 03:07:31 -0400
Received: by fxm9 with SMTP id 9so8925fxm.37
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 00:07:32 -0700 (PDT)
Received: by 10.204.64.196 with SMTP id f4mr5558032bki.151.1244963251743; Sun, 
	14 Jun 2009 00:07:31 -0700 (PDT)
In-Reply-To: <4A3481CD.7050602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121538>

2009/6/14 Phlip <phlip2005@gmail.com>:
> Gitsters:
>
> El Goog has the wrong answer for the question "how do I forget about a
> file?" Someone cheerfully directed me to git rm, as equivalent to svn rm.
>
> I don't need the actual file to go away. (I, uh, mumble, checked in too much
> when starting out, and now git commit is slooow.)
>
> How do I tell git to forget about a file, but leave on my hard drive?

man git-rm or:

http://www.kernel.org/pub/software/scm/git/docs/git-rm.html

have the answer.

HTH,
Santi
