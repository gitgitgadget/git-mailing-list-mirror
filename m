From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH 1/2] Change old system name 'GIT' to 'Git'
Date: Sun, 20 Jan 2013 21:16:50 +0100 (CET)
Message-ID: <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de, git@vger.kernel.org
To: gitster@pobox.com, davvid@gmail.com
X-From: git-owner@vger.kernel.org Sun Jan 20 21:17:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx1Kh-00084Z-45
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 21:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463Ab3ATUQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 15:16:52 -0500
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:47072 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752404Ab3ATUQw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2013 15:16:52 -0500
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id 95023212658;
	Sun, 20 Jan 2013 21:16:50 +0100 (CET)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 893DC3FE9CB;
	Sun, 20 Jan 2013 21:16:50 +0100 (CET)
Received: from webmail12.arcor-online.net (webmail12.arcor-online.net [151.189.8.64])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 80C5E9BCEB;
	Sun, 20 Jan 2013 21:16:50 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-14.arcor-online.net 80C5E9BCEB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358713010; bh=Ryp5o3cG74BsPA1DALGlgpmO0GMyrlhdYXCUEl9YsgI=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=Z1xBtJIIRIMoVRtaBCBJvGuRWKi3t06NYikb1Eq/yIU9mj6QBxg34Xd+Ry82CYoSl
	 0dQtr+iQMGZTbAPU8uowoo0tJ+0mpxhz8E9HX56u3QfToNzONgEOxUwTx32eZ3p58u
	 PYlh2znP2zb3OYWPzVWqj+NRjXy1IQbjh+vc4o9E=
Received: from [94.217.21.22] by webmail12.arcor-online.net (151.189.8.64) with HTTP (Arcor Webmail); Sun, 20 Jan 2013 21:16:50 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.21.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214045>

> 
> If I were to decide today to change the spellings, with an explicit
> purpose of making things more consistent across documentation, it
> may make sense to use even a simpler rule that is less error-prone
> for people who write new sentences that has to have the word.  How
> about treating it just like any other ordinary word?  That is, we
> say "git" (without double-quotes, of course), unless it comes at the
> beginning of a sentence?
> 

The widely used books on Git by Scott Chacon or Jon Loeliger (and
many others) are using 'Git' instead of 'git' when talking about the 
whole system. So IMHO it would not be wise to change our internal 
documentation from using 'GIT'/'Git' to using 'git'. The internal 
documentation should be a natural continuation of these books 
by content and style.

- Just my thoughts.


---
Thomas
