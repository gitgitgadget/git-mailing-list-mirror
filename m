From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: gitk - remembering views
Date: Wed, 30 May 2012 16:46:34 +0200
Message-ID: <m21um1bub9.fsf@igel.home>
References: <4FC5F5FB.2000607@letterboxes.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Nick <oinksocket@letterboxes.org>
X-From: git-owner@vger.kernel.org Wed May 30 16:46:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZkAg-0005r3-9L
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 16:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab2E3Oql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 10:46:41 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47885 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab2E3Oqk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 10:46:40 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3W2ZPl6BW3z4Kn8t;
	Wed, 30 May 2012 16:46:35 +0200 (CEST)
Received: from igel.home (ppp-93-104-155-151.dynamic.mnet-online.de [93.104.155.151])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3W2ZPl3v10z4KK27;
	Wed, 30 May 2012 16:46:35 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 24898CA2A4; Wed, 30 May 2012 16:46:35 +0200 (CEST)
X-Yow: America!!  I saw it all!!  Vomiting!  Waving!  JERRY FALWELLING into
 your void tube of UHF oblivion!!  SAFEWAY of the mind --
In-Reply-To: <4FC5F5FB.2000607@letterboxes.org> (Nick's message of "Wed, 30
	May 2012 11:27:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.97 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198812>

Nick <oinksocket@letterboxes.org> writes:

> Is there any way to get gitk to save these views and even share them between
> repositories?  There is a "remember me" checkbox in each view's settings, but so
> far as I can tell, that doesn't do anything: when gitk is restarted, the views
> are lost.

That works for me.  They are saved as permviews in ~/.gitk.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
