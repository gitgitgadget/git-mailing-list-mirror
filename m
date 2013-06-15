From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/2] Slightly prettier reflog message from checkout
Date: Sat, 15 Jun 2013 23:12:03 +0530
Message-ID: <CALkWK0=s_oza=2mUmAFhLZCbFzW4ZsW+ohkxOthmu0+iGhKLSw@mail.gmail.com>
References: <1371317906-3991-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 19:42:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnuUy-0004bf-DY
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 19:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab3FORmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 13:42:44 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:39434 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab3FORmo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 13:42:44 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so3881928iec.22
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pTYjkF+gXkqvbLx3AgYc2QtHxu12YylO+iJhr6Pgmm0=;
        b=AfcDtJRg8tKcgEX1aF3agXn21Pm7ryzD5DzvRrhtpBFh2tVRva2gqF9jXOGbI9zMrY
         ffYGgo7xbbWbaEGQdZH8jYvHjat/4zoejr94ItLvIFub8Sju1pXMyD71VN9D5pnV40Ex
         CHuJq3Y94Eg6Boh53Z9X/yMwe7yZmdXhd5JKDB5tmRpuGjj6eAaGf1zItXULOqgZGSPD
         GH4Zhnu6Gasoz5biYxF2u5emsBNkQsYs+FhgPPzmiDGSX0AsSCTgRJMlA0339lGG8TKZ
         hQctHnGRnqGFRA5QtFRclWQLmKCHog3XILSdiKoyut6/jwE0cGm950MXecrFfRzRT4iE
         OSRg==
X-Received: by 10.50.23.8 with SMTP id i8mr1485961igf.42.1371318163929; Sat,
 15 Jun 2013 10:42:43 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 15 Jun 2013 10:42:03 -0700 (PDT)
In-Reply-To: <1371317906-3991-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227965>

Ramkumar Ramachandra wrote:
> [1/2] is important.  [2/2] is a minor prettification, that wouldn't
> have been possible without [1/2].

I forgot to mention: some tests fail, and I'm investigating.  This is
an early preview.
