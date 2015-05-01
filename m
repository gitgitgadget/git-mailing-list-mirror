From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: Patch that modifies git usage message
Date: Fri, 1 May 2015 18:49:17 +0100
Message-ID: <CAKB+oNvSR4ifdCZAxTyhwoh-yeVxikB0+Z9+19MGyVv4yLB=Xw@mail.gmail.com>
References: <CAKB+oNtYbJXNb2wGzJCdQ5Ru5fq3HzcapSqiTVC_34=xDnTb7Q@mail.gmail.com>
	<CAGZ79kY1ZoYrVwVVqfyB+uMGsJo59qDxbDLgyo5qygSm=CUVhA@mail.gmail.com>
	<xmqqfv7gxnup.fsf@gitster.dls.corp.google.com>
	<CAKB+oNtKi6e7H9U75WEJDKH2KK349JT+vGE8+acHvM6SasCWfQ@mail.gmail.com>
	<CAPig+cROY5ZaXtAWpaMpe8JsuG1eSp2jhAsSh1dAsCSACgoFxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 01 19:49:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoF3y-0000vE-Oa
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 19:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbbEARtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 13:49:18 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34211 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbEARtS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 13:49:18 -0400
Received: by qkgx75 with SMTP id x75so54722747qkg.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z867MHTV4xMmicsbQbc0HLw2t6IATx+2WzBKV0xhbco=;
        b=OMo0+2b8qR18sYUWNH8+zhKp2aajfjEBQ9AkVnhQNL9CLsUM8MxS9GhQQ1MDuawo+W
         nx0Tmy+Tw1nJ3nce+rx8bm0H3SvVCyI3HAAXVGDtYZmHaWb//SGvb681rnlLrbG9nLQu
         kvrcdk1RwYRIZ4JW5nQ2xj8fy6xGoPw+8donVttuymQ6Q7AL88QVDHcjR/Xqij3B3DUM
         nCPcB2oFvDZXyE0cLBoxsgPSJUwtpA5EHYQZfzRbHo3XQ35GhPoNHLukDiI9A4dauk6X
         nUvsAAXCFjuCUMcRGpcas6zW/kv+KkC3t0qY7T3QKELeKqvY9P0W4h744nY9n9/hXACQ
         kW7Q==
X-Received: by 10.140.145.78 with SMTP id 75mr7283348qhr.61.1430502557411;
 Fri, 01 May 2015 10:49:17 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Fri, 1 May 2015 10:49:17 -0700 (PDT)
In-Reply-To: <CAPig+cROY5ZaXtAWpaMpe8JsuG1eSp2jhAsSh1dAsCSACgoFxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268165>

So in essence what you are saying is that i should instead change
error messages to lower case. And also i have seen an idea i want to
work on from
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
I want to work on this and will submit a patch as soon as i am done.
