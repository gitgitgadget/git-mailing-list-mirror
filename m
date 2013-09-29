From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/44] Ruby support
Date: Sat, 28 Sep 2013 23:20:05 -0500
Message-ID: <CAMP44s0x4ivR58A2Xf9RhOUn+dg=vKtQCoFtn_p3s++eM8ipfA@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0nfP5CZYSvqrYeBAqkjCE_Zg-QenRcNZcP3-K7qPrZhoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 06:20:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ8UO-0002Ho-7D
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 06:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890Ab3I2EUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 00:20:09 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:35489 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab3I2EUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 00:20:07 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so3463359lab.28
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 21:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=90JVNFp8SSi4EmzpwEmYlefH3WNGPRa9ciLk1PGW7hc=;
        b=DbalpeEViUseKzHVgo7Gc6XNPTHCkQt8Ou0R6yBYfJSKjIjUaZGZ90xeyKq2QjvIfS
         EFbeYDEBn7tw6nI2nPkzEeWGVF0waEUa/5UZZFbPN4uL+SH80BwNlIep7JGJZ31fv8Yr
         mahc1ZxexCcZaRyXn6i6oovp3DLCOYeKkQwyAYuxURgeodPvTT93pLlODu80WrZQh4Gh
         W9sLeTeRcNzwxFxVa4RSN2wAuagUbbqFASum5iO7Y+vx20SodTu5yRj5xPQz9akfpNO1
         8AKzzuLAAlq9lhqiyOwmcvehsjzOMQiQvhcFP7o+dcM3kBrRVAyT8xI0v4OdnOQNhlbZ
         alMQ==
X-Received: by 10.112.51.101 with SMTP id j5mr15867279lbo.17.1380428405368;
 Sat, 28 Sep 2013 21:20:05 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 28 Sep 2013 21:20:05 -0700 (PDT)
In-Reply-To: <CALkWK0nfP5CZYSvqrYeBAqkjCE_Zg-QenRcNZcP3-K7qPrZhoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235578>

On Sat, Sep 28, 2013 at 11:13 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Felipe Contreras (44):
>
> Thanks! In the meantime, can you publish this work somewhere so we can
> easily try it out?

Sure:
https://github.com/felipec/git/commits/fc/ruby

-- 
Felipe Contreras
