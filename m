From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: contrib/git-normal-to-bare.sh
Date: Tue, 28 May 2013 21:52:48 -0500
Message-ID: <51a56d80d8a59_8bf138be1c906c6@nysa.mail>
References: <CAOsGNSSFx7VEOmz4qTt9nz=SXzQCZH7PdZ+gnYVqLhmRmRcT-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Zenaan Harkness <zen@freedbms.net>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 29 04:56:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWYo-0002va-M8
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 04:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759431Ab3E2C4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 22:56:19 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:61248 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759413Ab3E2C4S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 22:56:18 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so10937572oag.37
        for <git@vger.kernel.org>; Tue, 28 May 2013 19:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=U3HcO3BGpiWhEdUFpkj6k5JAOKlKgXVuOktFqVyimpk=;
        b=sD7aoE0VAFh1vZDbPAARyZ143hQLqL6t5PZ48LT2w5zRLUx38JvfeMknq4FzO8MCr4
         87aDdG/Gfhjlf2+Lp7tr1cf158O6w/HuVqVGmu7VTTLlh57+MhJr6MPWrayMEcF7BYmc
         h2y1WoPZzHKcp+zQLr0MjAF9TElQFckEv3dT23+5MKGBQQDJUbQ7xTaqetfHqRAgh7s3
         ZmxW+X2WAy393rtG2QtAJ5W/4L0v6YU5MmGAq9JHp9i5IJ3vgDihZlBzgwSeA8DP3xMd
         rQoaAdarmdFakrXFRfKyvARlsZ70gbtIILZT6D1YRquixX1qC4QqImBDMxFh23ZL+PqF
         WuvQ==
X-Received: by 10.60.161.68 with SMTP id xq4mr462735oeb.8.1369796177748;
        Tue, 28 May 2013 19:56:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i2sm8411568obz.11.2013.05.28.19.56.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 19:56:16 -0700 (PDT)
In-Reply-To: <CAOsGNSSFx7VEOmz4qTt9nz=SXzQCZH7PdZ+gnYVqLhmRmRcT-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225705>

Zenaan Harkness wrote:
> This question comes up every now and then - how to convert from normal
> to bare, or vice versa.
> 
> This is just a start to a basic script to go one way. Needs more tests
> etc, but it's enough to get newbies (like me) off to a reasonable
> start.
> 
> PLEASE CC me, as I am not subscribed.

You do not need to ask to be CC'ed. Any mailing list properly configued would
not munge the Reply-To header, so anybody replying to this mail would reply to
you.

Git is a properly configured mailing list, just like all the mailing list in
vger.kernel.org.

Cheers.

-- 
Felipe Contreras
