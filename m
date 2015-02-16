From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] gitk: Remove tcl-format flag from a message that
 shouldn't have it
Date: Mon, 16 Feb 2015 16:27:12 -0700
Message-ID: <CAMMLpeR6TkZxFQBVJukC3KgXM-cJkRY31m8OthHxMkaZzLqGjg@mail.gmail.com>
References: <1421914779-30865-1-git-send-email-alexhenrie24@gmail.com>
 <CAMMLpeTvtzPuiQJVxAx-Ja4JsoUxih5azMaN7_RcLvajny6A6g@mail.gmail.com> <xmqqlhk6agxg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>,
	Git mailing list <git@vger.kernel.org>,
	patthoyts@users.sourceforge.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 00:33:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNVAF-0004c3-3y
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 00:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbbBPX1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 18:27:35 -0500
Received: from mail-la0-f47.google.com ([209.85.215.47]:45995 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbbBPX1f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 18:27:35 -0500
Received: by labge10 with SMTP id ge10so32548963lab.12
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 15:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QJxs/mwHtlB+3/NnsZ3Mwi7Wqtz/0B9lSVQhvhZYSeo=;
        b=Xbb3KKz7ioE5FZQ3HwrZx4UAgxcZ5W/7d7eFKhsCC6zDvHO5An/6+dUJ46g73CIhPh
         0apvUDyfqEp/MIOorcsu3z2anvatvp33wWRH/UXhz5ptfneK6wdRIUFTAOmzKRC4glhA
         wo8YfA5E0YgS3hEl2lJlRFJs0vrbSbPW0TcDYrvDwyV+QHw56GJJGabTWwC0Os5nhCtP
         E2R84GRdC4ysNieLa6gAy/LKrxAPVlJ4v50fZhD8Nllu4QTwZ2UOnzbAQMqNdcw44jcy
         DzCh652TYtyeX0O8GdUz3cf1LpQb9aAIShumGZ3lxBCb1emJgLNAnzEJJr3Y3Zi46usT
         UuGA==
X-Received: by 10.152.44.228 with SMTP id h4mr26244872lam.31.1424129253156;
 Mon, 16 Feb 2015 15:27:33 -0800 (PST)
Received: by 10.112.146.42 with HTTP; Mon, 16 Feb 2015 15:27:12 -0800 (PST)
In-Reply-To: <xmqqlhk6agxg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263925>

2015-02-09 14:55 GMT-07:00 Junio C Hamano <gitster@pobox.com>:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > This is just a friendly reminder that this patch has been sitting in
> > the mailing list archives for a couple of weeks, and it has not yet
> > been accepted or commented on.
>
> I think that is because the message was not sent to the right
> people, and also because the patch was made against a wrong project
> ;-).
>
> I'll forward it to the gitk maintainer after digging it out of the
> archive and tweaking it.  Thanks.
>
> Paul, comments?

Another week and still no comments on either this patch or the gitk
Catalan translation patch. Is Paul Mackerras still actively involved
in the project?

-Alex
