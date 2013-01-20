From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] INSTALL: git-p4 doesn't support Python 3
Date: Sat, 19 Jan 2013 17:31:35 -0800
Message-ID: <CAJDDKr6VD0vnL8x4bgJWLQZNQKR4vQrvJaL5_tdF_9znAW2XAA@mail.gmail.com>
References: <20130119120158.GH31172@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 20 02:31:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwjlP-0000Mn-ER
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 02:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab3ATBbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 20:31:37 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:51237 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab3ATBbh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 20:31:37 -0500
Received: by mail-ee0-f47.google.com with SMTP id e52so2280309eek.6
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 17:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=xXRKdxR8VriRT2p0K7LyGg2k00TwAuoQf+F54G2fYbw=;
        b=EwF80uKly0nnfte92EJeAUTRJTJ6ewJK6pZv1lOvn+xB00pSVv/htMXgCvSJ8qOyzw
         UFMp/Yv/3LfFCOnTGy0ozci8ZPQtR4YbiInU88UBnC0O+r8hojNnTpiXwVsaaDGnVARb
         4wVQFImfypvf03OtXqFCD2cmQuLT8q32ekzdg1Q6fbNC8c/cjKQLD6Z20W7ZLVCNvJCT
         OOW6ru+U+CuncojmPx0DICJBJl2a5NY7vUSU6seUCAdiZ64AGaX55wPAyuMlg2HESTBS
         XBFBxHmM9wKfyg8UbV31Uu3PLp3k02O8+kaIJ2osMgVh+Z0tD6BI9S2aala+7NcYu8/V
         PsBA==
X-Received: by 10.14.175.70 with SMTP id y46mr43485484eel.6.1358645495783;
 Sat, 19 Jan 2013 17:31:35 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Sat, 19 Jan 2013 17:31:35 -0800 (PST)
In-Reply-To: <20130119120158.GH31172@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213997>

On Sat, Jan 19, 2013 at 4:01 AM, John Keeping <john@keeping.me.uk> wrote:
>  Since Pyhton
> 2.8 will never exist [1]

Tiny typo: Python misspelled as Pyhton
-- 
David
