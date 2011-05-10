From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: git rebase --interactive commits order
Date: Wed, 11 May 2011 00:20:22 +0200
Message-ID: <BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
 <BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com> <m2d3jr1mev.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 00:20:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJvIX-0002JN-Rk
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 00:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab1EJWUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 18:20:53 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40061 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab1EJWUw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 18:20:52 -0400
Received: by qyk7 with SMTP id 7so1991107qyk.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=p9qshubnR5U6/K8mYe72sG5IHp5rA/aKjyrQVpAcMYY=;
        b=XtfVRO/RcPb4szDJyuY0/uJiwEoMFHqGEVjGIjuNDva6AjeB4ysuJU1yv1RAW0GuKm
         RT0hXLjrwywlyopPhU5DsA7qsqbuW7xyLglbCGtllafmBFGDPaafoKC8lv6MVO1YGVpw
         caYw8/HtH8DtftdriuWNjfzr/hBNxUM74bquM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=KAr1hAPBNBUMcxgGPPJu8j74Ttfhym5ZttdAuyOvFsCeEsy+JaK0DDghytR/NFlEkW
         AyDzdvDqfIvwP4aWRleEEJhV7OP88edjOqMN7mjSXwxttltgCO8EpI/tHrmdCO3FQQf/
         5B6gG+Dm2WABc1dnpmVzlMnaFXBCopJwA7NZ4=
Received: by 10.229.63.96 with SMTP id a32mr3031763qci.285.1305066052151; Tue,
 10 May 2011 15:20:52 -0700 (PDT)
Received: by 10.229.234.15 with HTTP; Tue, 10 May 2011 15:20:22 -0700 (PDT)
In-Reply-To: <m2d3jr1mev.fsf@Spindle.sehlabs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173374>

So, sounds like most people agree with me. What should we do for this
to happen? propose a patch?

Philippe
