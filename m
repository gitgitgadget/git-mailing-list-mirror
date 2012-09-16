From: Grant <emailgrant@gmail.com>
Subject: Re: Backlight control broken between 3.6.0-rc1 and 3.6.0-rc4
Date: Sun, 16 Sep 2012 09:21:44 -0700
Message-ID: <CAN0CFw0Pa9oTUEt7Zk_6SbeJBveiCys_PB5uWU_0_4dgbYw2qw@mail.gmail.com>
References: <CAN0CFw0p1g23b5vCVAaVYLeb7YkngoKmptRcB5ud-gx3PpZjfw@mail.gmail.com>
	<CAEBDL5XPBpO8ChPm=avoHCHv6SDfruURaCJtbNxihrPAKoKB-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 18:21:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDHbW-0007DS-6W
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 18:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab2IPQVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 12:21:46 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:39290 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab2IPQVq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 12:21:46 -0400
Received: by weyx8 with SMTP id x8so3404511wey.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=xOL4pi024aJ74qYEe0/n92KCyHaewRYl9cH5DceGVIw=;
        b=Ho0AClo+mKGqQZvTsoF1Aa8Y7zTR+6jLAHzK3xfG4VEmqq3T0r67ym/tadXfddtPpC
         yeFuaMjFmR+7E4XQ6b85ebP8zSpy43dCwnsbcQljzoyVElggihWmNL+9BoEAw1WwIC0D
         wkPsfqRo/zmFFKkjHSU/O+BcZA7uKpoMzWHesWfF/zRFA4TMdOybg+ma0QYVrL32xDk0
         G/1fgm8sF5Zf4cy9NDa9NJXMsGFrnD4kHb2oP9h8JGaqvgKJ+yOf+DhMRtVbqhV6zBy/
         qyp+oT8mF6NaltULnn2Li+Cs0HugMZM7rKFFG9naGwVMpt1F5vshb/Qdsq+iSBwdned+
         1Ikg==
Received: by 10.180.8.41 with SMTP id o9mr10655484wia.3.1347812504844; Sun, 16
 Sep 2012 09:21:44 -0700 (PDT)
Received: by 10.223.76.5 with HTTP; Sun, 16 Sep 2012 09:21:44 -0700 (PDT)
In-Reply-To: <CAEBDL5XPBpO8ChPm=avoHCHv6SDfruURaCJtbNxihrPAKoKB-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205630>

>> I have a Dell XPS 13 Ultrabook laptop.  Backlight control used to be
>> broken, it works in 3.6.0-rc1, and it is broken again in 3.6.0-rc4.
>
> Wrong list.  You probably meant to send this to the kernel mailing list.
>
> -John

Yes and sorry.  Somebody already straightened me out off-list.  I
should have already retracted this. :)

- Grant
