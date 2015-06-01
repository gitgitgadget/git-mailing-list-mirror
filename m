From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] l10n: de.po: translate "index" as "Index"
Date: Mon, 1 Jun 2015 12:34:31 -0700
Message-ID: <CAGZ79kb01tODVL+iMNWvQdxwUZujy8fy0B3ZiNwODoJ5kadzvw@mail.gmail.com>
References: <1432925644-26231-1-git-send-email-ralf.thielow@gmail.com>
	<556C0BFD.3060806@drmicha.warpmail.net>
	<3813728.oJDPxEPYet@cs-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, tr@thomasrast.ch,
	jk@jk.gs, phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Mon Jun 01 21:34:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzVTq-0008Nn-Im
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 21:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbbFATef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 15:34:35 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36235 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbFATed (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 15:34:33 -0400
Received: by qgf2 with SMTP id 2so51365323qgf.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UA9/N+p9hgJPs+G0NWCXUasEw94i59NL7N4eeF9JXVQ=;
        b=QdZTcQDfKJ+Okm/4MjlIa0SUjzYL5hfMD2TWPWFdVQOvr5mnEqsJrXdIckjI4Dj7YA
         07b0vZqTQjHj8vsQSm869uwhFt1kvEUkZ9R4KGSzqBu3AO1eRzBPQAEHy6TW/SUQLHEd
         DWBAxdrydh52kWxM/hQftEWScQ4Od5wG4M6IJ4EZq42cclNYnXEuW9saenaaQNYL8e0K
         ByhofNCNe3g9JGuHRpuj5qxyDCi7OPMHQpXA5sNUJLkBV3ax7UeCHSaycOpI0ldKZ38Q
         rg0/18kjqGFKiAo2kIi/0rclz+eBQj4O2+87yqfcqLiHlXylaoGYVGN//5f8YnddIXS/
         0xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UA9/N+p9hgJPs+G0NWCXUasEw94i59NL7N4eeF9JXVQ=;
        b=cbwOWAl8qqsZHr0Eqli7oM81D0cJ/BYmbYbx4LDuzGLy3acIy7R8jtL+JYcMTodq0I
         4CAy33N0VfGYNNlYvEmWm/6Lw3v66m+FN+Hao99gdjlxvorGmp0x2f1BQtAUzqwIkNU5
         iEhFLbol7gBGPZdZnOvxpd04D1gbZBXbDJZyeFZGUvLApEvoFjhtap6eMo8CzSLfZQME
         lIv0gXA5ajNmgvBZOMnJpQkFFT9+4cr89/b214XoLK1PyO9SPyFtredM6xznPT4NlOBs
         aRRFIe5AgZetvmeoijYmedUW6iJlfazIjNaDMjJf4zJ2e2lVQFyK33KSCKg9okigB+xa
         sTAQ==
X-Gm-Message-State: ALoCoQkCLfepM+KIkt3ISxIVHjz+o3CdK0nDT9YveLv3gk7CHzdluu3BmnJDcdlSWqM59pYmwgAQ
X-Received: by 10.55.22.143 with SMTP id 15mr41288620qkw.85.1433187272209;
 Mon, 01 Jun 2015 12:34:32 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Mon, 1 Jun 2015 12:34:31 -0700 (PDT)
In-Reply-To: <3813728.oJDPxEPYet@cs-pc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270463>

On Mon, Jun 1, 2015 at 12:26 PM, Christian Stimming <stimming@tuhh.de> wrote:
> "index" concept, my explanation routinely says "This concept is called 'index'
> but it has nothing to do with any associations you make with that word. Better
> remember this thingy as *** and replace the termin 'index' with *** every time
> you read about it." where "***" is my preferred translation. The facial
> expressions of the audience regarding "index" regularly confirm this approach
> as the better one. I never encountered anyone who says "Oh, but isn't 'index'
> a much better term for this than what you said..."
>

So the *** is cut out here, or do you literally advise to think of a
black magic box here?
I'd be interested to know your preferred translation, maybe that can
be used instead
of Staging-Area then?
