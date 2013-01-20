From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] fixup remaining cvsimport tests
Date: Sun, 20 Jan 2013 12:58:38 +0000
Message-ID: <20130120125838.GK31172@serenity.lan>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 13:59:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwuUM-00070Q-VO
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 13:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867Ab3ATM6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 07:58:46 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:60719 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab3ATM6p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 07:58:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 9DD7722B45;
	Sun, 20 Jan 2013 12:58:44 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mrigKhVB3DvZ; Sun, 20 Jan 2013 12:58:44 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 134AB1FC96;
	Sun, 20 Jan 2013 12:58:43 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A2140161E509;
	Sun, 20 Jan 2013 12:58:43 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qmDgNHodJTZc; Sun, 20 Jan 2013 12:58:43 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 7ABFB161E557;
	Sun, 20 Jan 2013 12:58:40 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1357878439-27500-1-git-send-email-chris@rorvick.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214009>

Hi Chris,

On Thu, Jan 10, 2013 at 10:27:16PM -0600, Chris Rorvick wrote:
> These patchs apply on top of of Eric Raymond's cvsimport patch.  7 of 15
> tests in t9600 fail, one of which is fixed w/ a cvsps patch I've sent
> to Eric (fixes revision map.)

Did you post the fix for the revision map publicly anywhere?  I'm hoping
to publish some fixes to command handling but would like to have the
tests passing first - and if you've already done the work...

Sorry if you have and I've missed it,

John
