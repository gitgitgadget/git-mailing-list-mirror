From: Christian Couder <christian.couder@gmail.com>
Subject: Draft of Git Rev News edition 11
Date: Mon, 11 Jan 2016 15:36:14 +0100
Message-ID: <CAP8UFD2eENdvYP5MMHf17C+fk8QNbHU0H2Z+2GVENC58h+6V+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 15:36:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIda0-0000Uk-Rl
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 15:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759002AbcAKOgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 09:36:17 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35408 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757612AbcAKOgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 09:36:16 -0500
Received: by mail-lf0-f53.google.com with SMTP id c192so214761923lfe.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 06:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=1XlOKHDil6l3bGWvo9LFOY9UXtlHBvsq7FjrO01VyMg=;
        b=lQfILpwE/adDIuu5R8ZU9qg/6hRX1ZOa4P2PQL/vpK8U4gFGzFC0mVyULIBZC0cTXk
         BGuJ6JPc6sSpaj11hKYE04UbhNJpJUjnzshE+pzdIiKguq0cGhtlxuvavIB05AlyGt0f
         mb5TBXisM+RiQXOinfawX6aQkxGnDULh1svS9U6fgbDBzsn9oe/B0L0P30gI+KlkpksW
         9DWP5RQVtTpiywVvOdkIJNIc5wz0NjO04IDxYWxQwVXfNKbktoriTHx4nGYrNnkI9gXs
         W+zqN05uJpGi/mfkmbtI3WEPofS+E3V/2MpuJU8U+vRD4dU2ELt2yViK9Sn1ozwH9uqJ
         hYBQ==
X-Received: by 10.25.155.81 with SMTP id d78mr1228707lfe.77.1452522974826;
 Mon, 11 Jan 2016 06:36:14 -0800 (PST)
Received: by 10.25.216.143 with HTTP; Mon, 11 Jan 2016 06:36:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283655>

Hi,

A draft of Git Rev News edition 11 is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-11.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/117

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Despite this draft being late, Thomas, Nicola and myself still plan to
publish this edition on Wednesday the 13th of January.

Thanks,
Christian.
