From: ellis@spinics.net
Subject: Re: plain text only policy prohibits the use of android based mobile
Date: Wed, 18 May 2011 16:22:24 -0700 (PDT)
Message-ID: <201105182322.p4INMOtH007490@amd.spinics.net>
References: <alpine.DEB.2.02.1105181612310.12174@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 01:22:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMq4U-0000NI-BF
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 01:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944Ab1ERXWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 19:22:25 -0400
Received: from spinics.net ([68.183.106.108]:36007 "EHLO spinics.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755849Ab1ERXWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 19:22:25 -0400
Received: from amd.spinics.net (amd [10.77.2.2])
	by spinics.net (8.13.8/8.13.8) with ESMTP id p4INMO5N016296
	for <git@vger.kernel.org>; Wed, 18 May 2011 16:22:24 -0700
Received: from amd.spinics.net (localhost.localdomain [127.0.0.1])
	by amd.spinics.net (8.14.4/8.14.4) with ESMTP id p4INMOOu007492
	for <git@vger.kernel.org>; Wed, 18 May 2011 16:22:24 -0700
Received: (from ellis@localhost)
	by amd.spinics.net (8.14.4/8.14.4/Submit) id p4INMOtH007490
	for git@vger.kernel.org; Wed, 18 May 2011 16:22:24 -0700
In-Reply-To: <alpine.DEB.2.02.1105181612310.12174@asgard.lang.hm>
X-Mailer: ELM [version 2.5 PL8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173916>

> if the client is sending out multipart mail with both a HTML and a text 
> portion, then having the list accept the text portion and strip the HTML 
> portion off seems like a reasonable request.

Reasonable, or no, it would involve changes in the way vger
handles the mailing lists and that is very unlikely to happen.
These lists have a long tradition of being plain text and there
is also a long tradition of not changing how things work just
because somebody comes along with a broken client. IMNSHO changing
the list to fix a broken client will only serve to encourage
more broken clients. And that would not be a Good Thing.

--
http://yosemitephotos.net/
