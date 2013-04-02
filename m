From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH 1/3] Remove outdated/missleading/irrelevant entries
 from glossary-content.txt
Date: Tue, 2 Apr 2013 19:24:57 +0200 (CEST)
Message-ID: <559824715.741522.1364923497242.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Tue Apr 02 19:25:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4xd-0005gu-NW
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932Ab3DBRY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:24:59 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:59454 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932078Ab3DBRY6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 13:24:58 -0400
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mx.arcor.de (Postfix) with ESMTP id 5332010784C;
	Tue,  2 Apr 2013 19:24:57 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id 4B4C73F83CC;
	Tue,  2 Apr 2013 19:24:57 +0200 (CEST)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net [151.189.8.68])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 3F08C10784C;
	Tue,  2 Apr 2013 19:24:57 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net 3F08C10784C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1364923497; bh=Jp+WZnl4oTzSDOWB9lcEbAircRT6QoLDzdmeO9Df3KQ=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=fmiflXTWgQA2sWT3ukrU5G6FeU1z8O3CubEf5CZiPaxKF4b3txVG2YgSi4hn2yccx
	 KPJOuaJ3TlTN2nxBFGpN5yOp4bcyH77PdGB6jrSWtVi93BBWKxB1oY+Sb3QVYMmUTy
	 D0p1cwRpEjsGiFXt6JO9oFRB2lCNpVmlMLQJ+c7E=
Received: from [94.217.19.243] by webmail15.arcor-online.net (151.189.8.68) with HTTP (Arcor Webmail); Tue, 2 Apr 2013 19:24:57 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.19.243
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219810>

 
> 
> The text indeed has a room for improvement, but it probably makes
> sense to have an entry for `directory` here, as folks who are used
> to say "Folders" may not know what it is.
> 
I assumed the number of such people so low that it's not worth
to keep this - to most people obvious - explanation.

> 
> Which one of outdated, misleading or irrelevant category does this
> fall into?  It certainly is not outdated (diff --cc/-c is often a
> way to view evil merges), the text defines what an evil merge is
> precisely and I do not think it is misleading.  Is it irrelevant?
> 
I considered it "irrelevant" because it tries to define 
"evil merge" which is - at least to my experience - not used
as some kind of well known notion. But I might of course be wrong.

> 
> Even though I personally am slightly in favor of removal, I suspect
> that is primarily because I already know what Git tag is, and it is
> different from the type tag in the Lisp-speak.
> 
I assumed the cardinality of the set of Lisp users is so small that
this addition will confuse more people than help somebody.


---
Thomas
