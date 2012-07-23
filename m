From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH] Add a svnrdump-simulator replaying a dump file for testing.
Date: Mon, 23 Jul 2012 21:28:45 +0200
Message-ID: <1406203.FoHCDc6FfD@flomedio>
References: <4514544.Xip1OCQ7Uj@flomedio> <5998541.c9PWeIAsEV@flomedio> <vpqr4s2jvhz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, davidbarr@google.com,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 23 21:28:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StOJM-0006ty-M2
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 21:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451Ab2GWT2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 15:28:51 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45311 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228Ab2GWT2v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 15:28:51 -0400
Received: by bkwj10 with SMTP id j10so5650505bkw.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=wSdC5hfQpguyc6CsbXeIhEv4LfilihbEtAluZ3nZlMA=;
        b=gVdx5CoKIFrOr5gKU0ji6xU3f/DqfKzeXX4lIC+YiayXDxxD/56sdV7nqxFSTcrGi9
         YdDZstn8A8gvadAYO9PQF1BGvLIXFYBi5ajAi50oftGRE4G9Dx7Wo4XXeragQDuCzvhk
         vpq8mr9JnewUdcI4Iv51zlbBAlO7fzvYhKgP085LsuTu+ZGlW9D4v84QImkLkfUwKekG
         g/CG6gXivQ0DdyJG2tjIgXt8MmbCJNTEuu4rN/wq0+gZGFC2AB7VC5YGrvN3EP5tsw52
         oHo0E3tGgRxx5Cb8RnZOEryfAXFlZXhOpb9jlQkarwA2scOJ8oGoMjoEQ6k5IrBtWe0H
         OVTQ==
Received: by 10.204.157.144 with SMTP id b16mr8454071bkx.122.1343071729936;
        Mon, 23 Jul 2012 12:28:49 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id y20sm8829069bkv.11.2012.07.23.12.28.46
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 12:28:47 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <vpqr4s2jvhz.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201966>

On Monday 23 July 2012 18:24:40 Matthieu Moy wrote:
> You also have whitespace damages (i.e. line wrapping introduced by your
> mailer). Using git-send-email avoids this kind of problem (there are
> also some advices for some mailers in Documentation/SubmittingPatches).

Damn. That's usually no problem with kmail either, if the config is right.
I've already used git-send-email several times.
But for replying to threads and adding several Cc: addresses it's a little 
cumbersome.
How do you do that in a nice way?

--
Florian
