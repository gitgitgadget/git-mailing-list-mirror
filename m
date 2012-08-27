From: Aaron Gray <aaronngray.lists@gmail.com>
Subject: Re: exporting a .git file ?
Date: Mon, 27 Aug 2012 15:39:16 +0100
Message-ID: <CANkmNDd6zPkrL-TueLnGCCyqP6eetxWh5KkL4vLGgUUddZFNhw@mail.gmail.com>
References: <CANkmNDc7VP4QiocxuB7JMuQyZy5nDT=ertow_ib2Hri_=XRMOA@mail.gmail.com>
 <503B8597.8040701@rktmb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Mihamina Rakotomandimby <mihamina@rktmb.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 16:39:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T60Tg-0006yS-4R
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 16:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab2H0Oji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 10:39:38 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38976 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab2H0Ojh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 10:39:37 -0400
Received: by dady13 with SMTP id y13so2586138dad.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pAwrKZzXdRh8kPHUOLgvrFBok31XZEUI+Q7GlRKHCJc=;
        b=0qzGLAWyV+purOwmsvMk2yjo39Qakjt5zkGsXg7u1F7+8ywq/A6lX+ajbd0ecCfUbo
         GS8Rwep2zkcGZlwSW7vFAUOsNLltV3GnbWKVbsTobv5S4CXLU2o053/5cJecIK20b+OZ
         yUed7mET6QAzSM8uz+8sENgtS2R+LmZlUwnp3Vp1YRx1rBgAePJcnBhGo1QCA64BRnvJ
         2P1ZN1IrzphM1TkbswAkwc8zHi3+tiRPMdDLyRbSFr1BnuvIi18Ww8Cxsd1eDAuxB8kH
         wekUCS7rtIYOlINw5Z3Kcx8JFcb4xBtxu7KiHl5yC8u1xcNLnpFfgkskyfIxEhtk0NN/
         6bkQ==
Received: by 10.66.75.168 with SMTP id d8mr30571960paw.63.1346078376887; Mon,
 27 Aug 2012 07:39:36 -0700 (PDT)
Received: by 10.66.85.233 with HTTP; Mon, 27 Aug 2012 07:39:16 -0700 (PDT)
In-Reply-To: <503B8597.8040701@rktmb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204345>

On 27 August 2012 15:35, Mihamina Rakotomandimby <mihamina@rktmb.org> wrote:
> On 08/27/2012 05:32 PM, Aaron Gray wrote:
>>
>> Is there anyway to get my git repository as a single file ?
>
>
> What is the purpose?
> ".git/" is a folder...

I realize that but I wanted to distribute it as a downloadable file
without having to use a server.

Aaron
