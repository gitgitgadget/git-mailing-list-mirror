From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] fixup remaining cvsimport tests
Date: Sun, 20 Jan 2013 15:28:57 +0000
Message-ID: <20130120152857.GM31172@serenity.lan>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
 <20130120125838.GK31172@serenity.lan>
 <CAEUsAPZKd+mw2iK7nd6rTtB8N+B99ud19FkuSx0HVitNxrxxZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 16:29:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twwpt-0001cQ-Lu
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 16:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab3ATP3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 10:29:08 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:44832 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab3ATP3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 10:29:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A9152CDA58B;
	Sun, 20 Jan 2013 15:29:05 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LcQlvK1JtAI5; Sun, 20 Jan 2013 15:29:04 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id E254ECDA5C6;
	Sun, 20 Jan 2013 15:29:03 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id DBEDA161E509;
	Sun, 20 Jan 2013 15:29:03 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WcC5Uv-UbzFI; Sun, 20 Jan 2013 15:29:03 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 94311161E480;
	Sun, 20 Jan 2013 15:29:00 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAEUsAPZKd+mw2iK7nd6rTtB8N+B99ud19FkuSx0HVitNxrxxZA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214023>

On Sun, Jan 20, 2013 at 09:22:03AM -0600, Chris Rorvick wrote:
> On Sun, Jan 20, 2013 at 6:58 AM, John Keeping <john@keeping.me.uk> wrote:
>> On Thu, Jan 10, 2013 at 10:27:16PM -0600, Chris Rorvick wrote:
>>> These patchs apply on top of of Eric Raymond's cvsimport patch.  7 of 15
>>> tests in t9600 fail, one of which is fixed w/ a cvsps patch I've sent
>>> to Eric (fixes revision map.)
>>
>> Did you post the fix for the revision map publicly anywhere?
> 
> It's in Eric's repo and included in version 3.8:
> 
> https://gitorious.org/cvsps/cvsps/commit/abe81e1775a8959291f629029513d1b7160bbde6

Thanks.  For some reason I thought the fix would be to
git-cvsimport-3.py.  Obviously I should have read more carefully.

Sorry for the noise.


John
