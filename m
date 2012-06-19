From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git on 64bit windows - state of the art?
Date: Tue, 19 Jun 2012 19:57:01 +1000
Message-ID: <CAH3AnrpsG_XL1OpAtwu_rrMX8t5TRVGsp8yD14na1ktvKTDHDw@mail.gmail.com>
References: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
	<CAGK7Mr62y4-fTFzuLGmuOd+zLkk+h1Q-rCb30TW3dWd8VLhhAw@mail.gmail.com>
	<CAH3AnrppdYOC_Z4PWnzNLWXPSSQMBvHd9KPnQyAt40=FTn2dFg@mail.gmail.com>
	<CAGK7Mr5byhUOZ1vZTOMWWBVs4rXdE8RH+SS2ppz2QP1e-MiG0w@mail.gmail.com>
	<CAH3AnromoeSc=34H14j92kFg3FjWbdg+XuZcd72Aq04zScvD8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 11:57:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgvBM-0001qo-J8
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 11:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246Ab2FSJ5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 05:57:03 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:33644 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab2FSJ5C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 05:57:02 -0400
Received: by weyu7 with SMTP id u7so4276002wey.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NEfffMdzRqBSMRTCeH5B2rF49oYuprnAPynjwzVl9fw=;
        b=YQvs8ryhbKwX145wSnLR8cvp7UlRwGMcUXznpbT0rTP0LvDl/5QCcB/cIiXuu/R6K+
         darWV527wkb746raKlq9uKeR3iJcZOmGp4eeK1zsoSjSNXCReSpI+46PJ5I65u8h9d0S
         923c94hztU58xQ1V9yglUwN5N026HbVtwRiQJ9wQq4/XHlowsZUXvKY8mX0Xu2Pu3GaY
         9Zusoup7SF86+v92ciDkH5tMR2pH4VEiPY4LH8JHgAuMD+9SS67S9M7l5RCxDBdZBPe1
         fKX+JoBkSWdl1k/NXUgBqALadOQf0KN1Owyt77RRTWefGYfTPbmbuGVOIOSyefOOz0WF
         uu8A==
Received: by 10.216.216.148 with SMTP id g20mr9982704wep.187.1340099821696;
 Tue, 19 Jun 2012 02:57:01 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Tue, 19 Jun 2012 02:57:01 -0700 (PDT)
In-Reply-To: <CAH3AnromoeSc=34H14j92kFg3FjWbdg+XuZcd72Aq04zScvD8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200191>

Would I be correct in assuming that Git For Windows doesn't support
"git svn" because of the dependency on a perl implementation that is
available with msysgit but not (perhaps?) "Git For Windows"? Or is
this an incorrect assumption?

jon.
