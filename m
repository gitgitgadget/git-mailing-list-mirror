From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 11/10] fixup! transport-helper: add support to delete branches
Date: Sat, 26 Oct 2013 23:55:33 -0500
Message-ID: <CAMP44s142HB2t7wL8KYTyD4M=e7X5hvG1KeOBhJHwSEjegYM9Q@mail.gmail.com>
References: <1381561533-20381-6-git-send-email-felipe.contreras@gmail.com>
	<1382848452-7953-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Sun Oct 27 05:55:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaIOH-0003Nz-JW
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 05:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104Ab3J0Ezf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 00:55:35 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:57913 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab3J0Ezf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 00:55:35 -0400
Received: by mail-la0-f42.google.com with SMTP id ea20so4258299lab.15
        for <git@vger.kernel.org>; Sat, 26 Oct 2013 21:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=o+N/CfFR7G+N0oFD1epTxzUD2tu5LHz5sy22or1rXHo=;
        b=SNrC9Z2P+E/j/p5MW7c6LuLqAjDFxCCtQAFHjjRldhJdLUcLt4GiCgRqaZSfsMhr+4
         u36pQU4X+eB3cx/SUE8RsAwQLWt1daaoPTBYGYFEfbejQ/9eY9tbceRW9fRbJW5goTXs
         X5Uhr96N0VBVJSzSPoTEVyVQe6hCT1Z7zkA36+Q8SYcwv+R9o36v7a1t6G7jZu5pgWr/
         Ua3XlV49CvCwG21PmY61MJWxmpq0twJmKqYJt1eTwbU7kabVBGgMCFTW1DV3dr2qQPmf
         Per2v0D8YGf67ThtLHkAfofCEzSHMyPn/sgIiPxuB5u4uyGHRytoz6dNVsFDfW9Q6YQT
         LMjA==
X-Received: by 10.152.6.202 with SMTP id d10mr30042laa.49.1382849733540; Sat,
 26 Oct 2013 21:55:33 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Sat, 26 Oct 2013 21:55:33 -0700 (PDT)
In-Reply-To: <1382848452-7953-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236773>

On Sat, Oct 26, 2013 at 11:34 PM, Richard Hansen <rhansen@bbn.com> wrote:
> Patch 2/10 (transport-helper: fix extra lines) deleted one copy of the
> lines; patch 9/10 (transport-helper: add support to delete branches)
> should delete the other copy of the lines.

Looks awfully familiar to:

http://article.gmane.org/gmane.comp.version-control.git/235973

But since the project does have double standards, you might have
better luck by simply not using my name.

-- 
Felipe Contreras
