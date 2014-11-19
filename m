From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: ag, **, and the GPL
Date: Wed, 19 Nov 2014 07:51:37 +0700
Message-ID: <CACsJy8AcS5CJqk5mBNZxcws9PUDdUpPVkoNdQnPsYyQeHTUd6Q@mail.gmail.com>
References: <CACr0F2iGY_vxWzsNaPQNJ2cLUDRZPS70i79EhyA9OkA7qLaUQQ@mail.gmail.com>
 <20141118190918.GH6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthew Kaniaris <mkaniaris@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 01:52:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqtVF-0004gm-UR
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 01:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbaKSAwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 19:52:09 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36004 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbaKSAwI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 19:52:08 -0500
Received: by mail-ie0-f177.google.com with SMTP id tr6so6031833ieb.8
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 16:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XDXkvmGW0Vs4+SjYpcoGznzgnWk8lAJHqNca39iSw24=;
        b=UnUbCq/5RgyY7O9y0MFG9qrloUVkfbwB49ho1WtJTcrqxZoDAiKsQ3CajLi7noT73j
         Q/pjYX/xGNN0f//Bgzq/aDBO4PiGf0SFteEX/zbLyv40ptqSA2k4u/NMKoBp0U8EhPOv
         ENrrClhNc01Uuy5vGjw3nW5NEw2tLXIsDCwkYVDsK10f2jU1MJBWd/Cpu3fbSBuHZVSU
         O6kMSWKbbkLA//T9JnDEEfokTQgBOreMY0eyViaKj5vzqLCb4hPPp3ldwrcTUyrOKYcI
         x0a4YaSgCXI1mzcg0xLCDhcmM1MdFHWPRtlSJsQx8/wBlmP75uSsglFsOoBQX5xIjwDl
         d8CA==
X-Received: by 10.107.34.9 with SMTP id i9mr39934255ioi.33.1416358327687; Tue,
 18 Nov 2014 16:52:07 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Tue, 18 Nov 2014 16:51:37 -0800 (PST)
In-Reply-To: <20141118190918.GH6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 19, 2014 at 2:09 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Duy, what would you think of making git's wildmatch.c "GPL v2 or v3,
> at your option"?

wildmatch.c is not really owned by me (latest change is from Anthony
Ramine), but I would be ok with that.
-- 
Duy
