From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 14:15:47 -0500
Message-ID: <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
	<1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 21:16:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlOcP-0000Y1-Jr
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 21:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614Ab3FHTPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 15:15:50 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:37337 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab3FHTPt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 15:15:49 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so4690208lab.17
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 12:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kbcy5HfiPU8JIq3UEMMe8EiMumrEZr1/sN0ANwGQswA=;
        b=PgF/Qum3tGHmnFgYjXVPjWXsxKTtFrIHibQhgLNXKOWQIdBDMDSfiqq/6w4S8mnfvb
         h8hEAB2Uoy+3ZJ3CUa84qT/iS5nijBV8PYuORm3y0Yai6Yma/GI1dt1kDoz8NqaA91VV
         Ar6+H/kJkjd/G2Qa+VEI+qTng9CDVrqXGA1XV8/37kcIEOd/cAGl9mEXcLZw50YHXHgl
         gu/cy1yxpeMo/5p6v6YY9KPG1yY/LNOZyU0R1qAvycSHsHmxA8x6HrH/qCWSOYgZdMou
         06ZvfvzjZJFUfaeEW/JlUx1/Qa95SrmtorcZ/Wmy6INrSHo/OZvBkh3zKXmAJhwzzjt1
         iMSg==
X-Received: by 10.152.22.73 with SMTP id b9mr1841017laf.36.1370718947797; Sat,
 08 Jun 2013 12:15:47 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 12:15:47 -0700 (PDT)
In-Reply-To: <20130608173447.GA4381@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226859>

On Sat, Jun 8, 2013 at 12:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> If I were managing this list, I would ban mails from you, since this
> discussion style does more harm than good.

There is a nice motto around: "Talk is cheap. Show me the code."

Just the past three months I've probably done more work than anybody
else[1], and you would ban me because you don't like my words? At the
end of the day the project has benefited from my patches, and a wise
maintainer would do what is best for the project. If you don't like my
words, ignore them.

Taking things personal is more often than not the wrong thing to do.
Specially when they were not even directed to you.

[1] https://www.ohloh.net/p/git/contributors?query=&sort=commits_12_mo

-- 
Felipe Contreras
