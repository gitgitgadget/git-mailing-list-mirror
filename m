From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git-svn: show progress in working_head_info()
Date: Wed, 14 Jan 2015 17:40:23 -0500
Message-ID: <CALkWK0nJdkk0D3R62upGWm24s4vqF5tehkb5fU=nWMnCJ-OGWw@mail.gmail.com>
References: <1420896096-15254-1-git-send-email-artagnon@gmail.com> <20150110222135.GB32253@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 23:42:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBWdR-0002GV-Ph
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 23:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbbANWlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 17:41:06 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:59785 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbbANWlF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 17:41:05 -0500
Received: by mail-ig0-f179.google.com with SMTP id l13so11600739iga.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 14:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j3YKuKrZ/6EE49xPU3riggarCWbhuvD1E5knzATd7u0=;
        b=BUffP9ycTq4F+0zDGxjjrbcmSsP9Kqq9fckl+I5W8dlN962lDSYRPyoozALZVPGi0/
         c1YjHVATOFvbZadCK0NpfZai65/PwTDOyehssqiFpTjOSTZ1FbwYDDffnoDRI5c9LxKi
         iYgSZHaamaBoH5PkFY+u21lsvj8lSFMptOTvrhjh9eRD8Zrto/+t4BJ+kDuGQs7aagun
         JtHXz9J3mN6UUiEkhaM2iM4RogE0wd0vptQC8qejeavTVLP1J9YEaX68DpSN1aBVN/Hr
         WS9DCS1b0NCPHPNo9pAsg7x0PM2eRJZFr6F/8jTIfXuSy05W8x5uCbbl/AOyxH/WebSz
         Yddw==
X-Received: by 10.107.166.149 with SMTP id p143mr7187702ioe.16.1421275263860;
 Wed, 14 Jan 2015 14:41:03 -0800 (PST)
Received: by 10.107.13.18 with HTTP; Wed, 14 Jan 2015 14:40:23 -0800 (PST)
In-Reply-To: <20150110222135.GB32253@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262438>

Eric,

I'm sorry, but this change isn't important enough for me to follow up.
Please merge the other two patches, if you think they're good.

Thanks.
