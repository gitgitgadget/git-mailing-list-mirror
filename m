From: Pete Harlan <pchpublic88@gmail.com>
Subject: Re: [PATCH] config --global --edit: generate correct .gitconfig template
Date: Wed, 6 May 2015 11:10:59 -0700
Message-ID: <CAM=ud8xTwmR-4TRCXkDJGGB0R6y8kdqN_=Px0H6PAC7BLN_wFA@mail.gmail.com>
References: <1430934077-20724-1-git-send-email-pchpublic88@gmail.com>
	<xmqqzj5htws0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu.Moy@imag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 20:11:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq3mm-0003ua-8t
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 20:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbbEFSLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 14:11:01 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:34592 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbbEFSLA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 14:11:00 -0400
Received: by qcyk17 with SMTP id k17so8972464qcy.1
        for <git@vger.kernel.org>; Wed, 06 May 2015 11:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sgGIP/Xoxuv17rK+ylcrC9GNK6EZpd2pt28jfeRh2yk=;
        b=OzdP5y1COcbHjXTzyqhbibAMr5rSaBLXewzWVk1umouv4EZo6uA0ilQ9OqS4axjWvf
         YQOGxqBwHXEM+ayX6Df+VeiqsrevUoMgZ8H8qCxIONhJvG4jlMD1sEcUZK4AkN7th3Zo
         wPX65dPVKx6GNkSY4uatneC29+9O2Z6HJDUmO/M9HuUZj5WuoFvoA9Eu53iuFVxagEEe
         SzlwURxUaI/7ogY6uSYnW3TcYW/60gd1G53CuvDoO8rbDj3apT0NXY3KP52uKYXvT1VB
         K1eWmK2QuHSXbqjkVlgy/HgLYlswrovpxlHhWvQ77dVECz0SbBbHMohVzEA6JeDBEftM
         Z5kA==
X-Received: by 10.140.92.165 with SMTP id b34mr40624317qge.13.1430935859613;
 Wed, 06 May 2015 11:10:59 -0700 (PDT)
Received: by 10.140.40.80 with HTTP; Wed, 6 May 2015 11:10:59 -0700 (PDT)
In-Reply-To: <xmqqzj5htws0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268478>

On Wed, May 6, 2015 at 10:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks, I think this was already done in 7e110524 (config: fix
> settings in default_user_config template, 2015-04-17).

Whoops......indeed, I'll check more than just master next time, thanks.

--Pete
