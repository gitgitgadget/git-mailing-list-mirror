From: Christian Couder <christian.couder@gmail.com>
Subject: Draft of Git Rev News edition 10
Date: Sun, 6 Dec 2015 00:24:32 +0100
Message-ID: <CAP8UFD27=zeYShL95ErqXoSgUNTZuPchDezbzNhAOus7WQkLew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pat Thoyts <patthoyts@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	James McCoy <vega.james@gmail.com>, James <rouzier@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <stefanbeller@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 06 00:25:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5MCJ-0007Ct-0k
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 00:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbbLEXYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2015 18:24:34 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35244 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbLEXYd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 18:24:33 -0500
Received: by lfdl133 with SMTP id l133so131857272lfd.2
        for <git@vger.kernel.org>; Sat, 05 Dec 2015 15:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=Lss9tli+amMrC3KwwfBrMf+ctlrIc5qqXbmCmrKWHdI=;
        b=JWcibabUShip9PfpAG264CBm1in0p459EfdPkdc3nqA/UgseqnUNopwtFO5toXiOrX
         AzUnwHJfnYql8fh3u2oY9U1+gzaYPAc4VaHhVESvs/LUYkPgl4pzAeCmTrN8jfUUMQwa
         1bX/or9Q0R3An5GmAMCm7vqCVHd0dtAUIBx8/qUB0pl+AIVt6dA+6fJgaARiAKycmJY3
         ZU9ZnB362oWzvYNp7lvFh3NuM46d57BLmNej4zl8Oc6EqtwJvHK3k0pXqwgh2cnfmqD4
         asDhQECBxUoOdnkT1Lo//FL4jHe1vzqC1QG0gLZANs3YFjRJuWUH3EtKnmLGBY8gtxMc
         OtZA==
X-Received: by 10.25.207.205 with SMTP id f196mr10623382lfg.124.1449357872244;
 Sat, 05 Dec 2015 15:24:32 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Sat, 5 Dec 2015 15:24:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282039>

Hi,

A draft of Git Rev News edition 10 is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-10.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/112

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Nicola and myself plan to publish this edition on Wednesday
the 9th of December.

Thanks,
Christian.
