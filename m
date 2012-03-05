From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: A possible fmt-merge-msg update?
Date: Mon, 5 Mar 2012 12:33:42 -0800
Message-ID: <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org> <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 21:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4ebk-0001yh-NI
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 21:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430Ab2CEUeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 15:34:05 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:37078 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332Ab2CEUeD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 15:34:03 -0500
Received: by wejx9 with SMTP id x9so2606887wej.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 12:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=X7VGLZuunWmT1ak7stjha4jHo4rl+fgaBpO3yHnzbbE=;
        b=ExznOa6RJ253SJ/IEYnM2+pUWDWbTRLS2NciOVYH5eAlU9aVVGDkIoROMwhX3YY+oe
         wIo4TxTd9fYxkS74IR7LgB/iN3DDnVkxomkk44KsT2GwINfjX+Rg0H/uR+V2qfmOqvsr
         JwethqZoj7HCWPtFon6vyEdN5f/bcfY3ICpcmWoUujrBOssxHw8/5T2JxJbNu6y3yQpn
         6CZfvYGUbwjajqYdoKLTR3jUbnDtbX3HSjE2GymbkWU1Q7H2PnOhOvXw/wBxTGOFjRSh
         J8QtrCSzsc+ZYB9z72iDy5YZ9wcEpbJx3QPaXr5Bj0twBnMTklV7ya4pNrR+YZ0rMTPt
         5Pvg==
Received: by 10.180.85.35 with SMTP id e3mr14210252wiz.6.1330979642243; Mon,
 05 Mar 2012 12:34:02 -0800 (PST)
Received: by 10.180.81.166 with HTTP; Mon, 5 Mar 2012 12:33:42 -0800 (PST)
In-Reply-To: <7vipii27ka.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: gO2ddzbRn9CYFUQo_4V18Ev9H-Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192271>

On Mon, Mar 5, 2012 at 11:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> The attached would give me:

So this isn't interesting to me.

Authorship is less relevant than submaintainership. So I'm more
interested in *committer* information than authorship information.

Of course, since you do it in branches that you maintain, to you
committer information is pointless. But I pull from submaintainers,
and then it really is the committer part that is way more relevant.

                          Linus
