From: John Szakmeister <john@szakmeister.net>
Subject: Re: Backlight control broken between 3.6.0-rc1 and 3.6.0-rc4
Date: Sun, 16 Sep 2012 08:12:06 -0400
Message-ID: <CAEBDL5XPBpO8ChPm=avoHCHv6SDfruURaCJtbNxihrPAKoKB-Q@mail.gmail.com>
References: <CAN0CFw0p1g23b5vCVAaVYLeb7YkngoKmptRcB5ud-gx3PpZjfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Grant <emailgrant@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 14:12:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDDhy-0001zT-Ra
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 14:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab2IPMMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 08:12:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57581 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab2IPMMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 08:12:08 -0400
Received: by iahk25 with SMTP id k25so4680440iah.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=1/FJKz0AEyxFJdWs0+ltqyRDwg8AUJSmJUNEim00C0U=;
        b=mQFVh11/s7PZdS0beoYXclnhyCUNcEEFQldWEFC5AuQMfRcms3DKW3Yj0XT8m6/LTU
         lKU85nc4XVLkC0ifkCtpSfGUvlsdYGYZ2uOaggl2Qdq+VAJ9KgyBwnIFM1S9rblZiQzY
         zGDkQOXac7EdahMg9g0kxlTQRkPuH+F1syP1SbNKy285ySZXItz19RjlNFu+x2sU1bVH
         JTm8lliIeEEUsbFaDn/NZ1oENa8HBLYPy4MFjvoffn3lVUbyYZZ2Q19LjQoyJhmd8qiw
         ilBAumJr29bYNeq9cz6qjyiXOItc5X6CdO4LHL51Mosu5UUNyxq61vjXuf+DDkcylH/r
         +udA==
Received: by 10.50.160.233 with SMTP id xn9mr4035263igb.37.1347797526888; Sun,
 16 Sep 2012 05:12:06 -0700 (PDT)
Received: by 10.50.163.5 with HTTP; Sun, 16 Sep 2012 05:12:06 -0700 (PDT)
In-Reply-To: <CAN0CFw0p1g23b5vCVAaVYLeb7YkngoKmptRcB5ud-gx3PpZjfw@mail.gmail.com>
X-Google-Sender-Auth: sKX_Yf4Gp2kk3LTlz7-O0aV2EoQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205611>

On Sun, Sep 16, 2012 at 5:30 AM, Grant <emailgrant@gmail.com> wrote:
> I have a Dell XPS 13 Ultrabook laptop.  Backlight control used to be
> broken, it works in 3.6.0-rc1, and it is broken again in 3.6.0-rc4.

Wrong list.  You probably meant to send this to the kernel mailing list.

-John
