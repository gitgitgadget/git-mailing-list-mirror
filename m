From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: Regarding download of one *.git repository
Date: Mon, 9 Jul 2012 18:55:51 +0530
Message-ID: <CAH-tXsDgNymxtKFkjaZqfbbgV0KwDBwZGOuiTZ3FH_GuUb_2Sg@mail.gmail.com>
References: <twig.1341816914.75923@cdac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Shraddha Shardul Desai <shraddhav@cdac.in>
X-From: git-owner@vger.kernel.org Mon Jul 09 15:26:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoDz5-00006Q-9i
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 15:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab2GIN0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 09:26:33 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:50316 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab2GIN0d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 09:26:33 -0400
Received: by wgbds11 with SMTP id ds11so2647860wgb.1
        for <git@vger.kernel.org>; Mon, 09 Jul 2012 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NyxjNMigzigtxbmXcgMVQ3LqSpSd880b5yOoWToRHQ8=;
        b=01eox2c35gEUDtMd4Sx7Y+VxE3xHQvU6zW2+VWVwLSkv81gwGE632Sz86cwjV5EYEU
         1kUz6FCA5fXF/Gttsita/wdVHM9BZXqgeeGTEQJQOp5DZCV8Do0P/kIaA7w6jwhgkbtl
         wtjN+O2QjBF9dQna5ZewDyehpgjdBS14EjhOuprr7UIpWcUMC0dHJ70X4vM3Y5Q1cQWB
         S1v8U5vk7NeVtkIHmEjkUAEaWpzHFGABYSA63GnBK+O4ChWqS288Caq3BUteq0qjGofv
         /1FV7IK8k3HxZRRc50BfBo5JnmQA07zcoCDOTX9hroP9Dju+muns+aatuzV1Zl+jcM1I
         8EFA==
Received: by 10.180.84.164 with SMTP id a4mr14651983wiz.12.1341840391636; Mon,
 09 Jul 2012 06:26:31 -0700 (PDT)
Received: by 10.223.147.75 with HTTP; Mon, 9 Jul 2012 06:25:51 -0700 (PDT)
In-Reply-To: <twig.1341816914.75923@cdac.in>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201203>

On Mon, Jul 9, 2012 at 12:25 PM, Shraddha Shardul Desai
<shraddhav@cdac.in> wrote:
>
> Dear Sir,
>    I want to get RAxML source from
> https://github.com/stamatak/RAxML-Light-1.0.5.git.
>    I have installed git utility on my linux.
>    What I need to do to download source of RAxML with help of GIT.

$ git clone git://github.com/stamatak/RAxML-Light-1.0.5.git

I would suggest some reading on git. Progit [1] is a great book for
learning more.

1 :  http://git-scm.com/book


--
Jaseem Abid
http://jaseemabid.github.com
