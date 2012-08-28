From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH v7 00/16] GSOC remote-svn
Date: Tue, 28 Aug 2012 10:59:58 +0200
Message-ID: <2052320.5WmLkH0W9f@flobuntu>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 11:00:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Hef-0008If-1d
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 11:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab2H1JAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 05:00:05 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45579 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab2H1JAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 05:00:04 -0400
Received: by bkwj10 with SMTP id j10so1536750bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=kKTvX7zZRlDf0YzAWYHSm5UC2nVgHNdDvvhumt/v0IM=;
        b=LgMHpdh4VXTHAoTuZFPX4ucx49TEBx6IYxTXoIFgJyreayAMGLXDavwZ9seoPJy2OK
         ID00/f/rjyffchk6HhNDvJP3bUYOoRW/USqCBwEWGMdr0yDQYmqgM+nqr7isCQDHFd2o
         8+3kF+oP1Lz8aMNg9l2iw1e0kJXUVHYmc2kao3+5zRTh+CrwhtbOeTJ3pfxoKMc9S4OG
         7jGtn88R972eiY41SfAdBs7A3BLTKsgcBF5LFVibYRhzStjck6X9jk9tOSL7w0VvWo02
         5VaUiziZ6gDC7VA8RcboCfY4MpY9upxh2xGlIhp3kEWphbuuxXi/mCimSsc5s7YW6QRa
         Iylg==
Received: by 10.204.148.86 with SMTP id o22mr4720576bkv.59.1346144402157;
        Tue, 28 Aug 2012 02:00:02 -0700 (PDT)
Received: from flobuntu.localnet (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id j9sm12081239bkv.0.2012.08.28.02.00.00
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 02:00:01 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-29-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204418>

On Tuesday 28 August 2012 10:49:34 Florian Achleitner wrote:
> Reroll includes fixups by Ramsey. Thanks!
> Diff:
> [..]
> - improve compatibility of integer types.
> [..]

This line is wrong in this series. Just delete it. Sorry.
