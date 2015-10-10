From: Christian Couder <christian.couder@gmail.com>
Subject: Draft of Git Rev News edition 8
Date: Sun, 11 Oct 2015 01:36:15 +0200
Message-ID: <CAP8UFD1a=1c2g9MfeSo1rPL7BFrFQG9RQY6OmdaJQtoL2wZang@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Lars Schneider <larsxschneider@gmail.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Stefan Beller <sbeller@google.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Roberto Tyley <robertotyley@gmail.com>,
	=?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 11 01:36:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zl3gi-0001DR-Cb
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 01:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbbJJXgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2015 19:36:18 -0400
Received: from mail-lb0-f193.google.com ([209.85.217.193]:34899 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbbJJXgR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2015 19:36:17 -0400
Received: by lbcao8 with SMTP id ao8so11431396lbc.2
        for <git@vger.kernel.org>; Sat, 10 Oct 2015 16:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=kYr+LNDzZo/1YCbhK5bbtYcOnDeUtzt6gYDbbFgQ88k=;
        b=X2TKOlwhyFMsjlTtEtnal3WuFBLKsic4CaGEjjuLxe/P0sVhfIOT1rzAp5GtGg27qr
         LUu/I8+aaHmQmN8cE5QLVzRAPzd5AjAWVGfAGyTVY0B98l8Adk2od2Rkp+uw8MlyJW6H
         wqUHH1aElolnyQH0SnXOa91+7TJhjmL9jemVhHV19kK2fGfPmPRt1gbYv3362cQcpgTV
         b1UdkLJGvtDLPXIpj8Oj9BNMVFbpg1Do3EUfc614iPOSAZKGonTR7eqmIBE8oA0svOCH
         QNy68nnguJKuZz7dc0zZ//vh+JKbTaL29q2B6dpxkPG++jyVxbZkZgYgJHVzoPOhiAZK
         vaTA==
X-Received: by 10.25.20.167 with SMTP id 39mr6448997lfu.28.1444520176004; Sat,
 10 Oct 2015 16:36:16 -0700 (PDT)
Received: by 10.25.89.130 with HTTP; Sat, 10 Oct 2015 16:36:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279331>

Hi,

A draft of Git Rev News edition 8 is available here:

https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-8.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

https://github.com/git/git.github.io/issues/100

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Nicola and myself plan to publish this edition on Wednesday
the 14th of October.

Thanks,
Christian.
