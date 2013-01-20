From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: [PATCH 0/2] GIT, Git, git
Date: Sun, 20 Jan 2013 09:38:43 +0100 (CET)
Message-ID: <304952858.714413.1358671123163.JavaMail.ngmail@webmail06.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 20 09:39:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwqQo-0002ER-KH
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 09:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247Ab3ATIip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 03:38:45 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:52868 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061Ab3ATIio (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2013 03:38:44 -0500
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mx.arcor.de (Postfix) with ESMTP id 337B2D8676
	for <git@vger.kernel.org>; Sun, 20 Jan 2013 09:38:43 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id 2CC702E6103;
	Sun, 20 Jan 2013 09:38:43 +0100 (CET)
Received: from webmail06.arcor-online.net (webmail06.arcor-online.net [151.189.8.133])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 2B35630258;
	Sun, 20 Jan 2013 09:38:43 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-02.arcor-online.net 2B35630258
Received: from [94.217.21.22] by webmail06.arcor-online.net (151.189.8.133) with HTTP (Arcor Webmail); Sun, 20 Jan 2013 09:38:43 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.21.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213998>

 
> 
> Git changed its 'official' system name from 'GIT' to 'Git' in v1.6.5.3
> (as can be seen in the corresponding release note where 'GIT' was 
> changed to 'Git' in the header line).
> 
> Alas the documention uses 'GIT', 'Git' or even 'git' to refer to the
> Git system. So change every occurrence of 'GIT" and 'git' to 'Git'
> whenever Git as a system is referred to (but don't do this change
> in the release notes because they constitute a history orthogonal
> to the history versioned by Git).
> 
> [PATCH 1/2] Change old system name 'GIT' to 'Git'
> [PATCH 2/2] Change 'git' to 'Git' whenever the whole system is referred to
> 

My second patch somehow got lost in the mailing system (I suspect
due to its size of >300kB). I will wait for some more comments
and then do a reroll thereby splitting the second patch in smaller
parts ...


---
Thomas
