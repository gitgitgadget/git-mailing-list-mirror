From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: Aw: Re: [PATCH v3 1/6] Change old system name 'GIT' to
 'Git'
Date: Tue, 22 Jan 2013 19:27:05 +0100 (CET)
Message-ID: <166890920.792266.1358879225366.JavaMail.ngmail@webmail06.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: davvid@gmail.com, git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Tue Jan 22 19:27:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxiZN-0005So-Ow
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 19:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab3AVS1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 13:27:09 -0500
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:44725 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754405Ab3AVS1G (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2013 13:27:06 -0500
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mx.arcor.de (Postfix) with ESMTP id 6C6AF21274D;
	Tue, 22 Jan 2013 19:27:05 +0100 (CET)
Received: from mail-in-18.arcor-online.net (mail-in-18.arcor-online.net [151.189.21.58])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 6900C116007;
	Tue, 22 Jan 2013 19:27:05 +0100 (CET)
Received: from webmail06.arcor-online.net (webmail06.arcor-online.net [151.189.8.133])
	by mail-in-18.arcor-online.net (Postfix) with ESMTP id 5D4AE3DC35C;
	Tue, 22 Jan 2013 19:27:05 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-18.arcor-online.net 5D4AE3DC35C
Received: from [188.98.228.106] by webmail06.arcor-online.net (151.189.8.133) with HTTP (Arcor Webmail); Tue, 22 Jan 2013 19:27:04 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.228.106
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214242>

 
> 
> I left this as-is in my "fixup" commit, as the html and manpage
> backends seem to typeset the section titles differently.  I however
> have to wonder what the result will look like if we replaced it with
> 
> 	Typical use of Git credential
> 
> Can you try and see how well it works?
> 
The html and manpage backends both don't change the 'poor-man's bold face'
of the section titles and all the rest of the documentation uses this same style.
So we should leave this as is.

> 
> I'd really hate to see these patches posted again to the list and
> asking for re-reviewing the whole thing.  Can we go incremental
> while parking these original patches on 'pu', and later squash the
> whole thing into two commits, or something?
> 
Of course.


---
Thomas
