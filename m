From: =?ISO-8859-1?Q?Deniz_T=FCrkoglu?= <deniz@spotify.com>
Subject: Reviews on mailing-list
Date: Sat, 10 Nov 2012 15:19:21 -0800
Message-ID: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Shawn Pearce <sop@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 00:19:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXKLE-0000Em-Jb
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 00:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376Ab2KJXTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 18:19:43 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33513 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab2KJXTm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 18:19:42 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so3358879wgb.1
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 15:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :x-gm-message-state;
        bh=KIw09nU1Q/PkmmZbua/4wdbug5/SaVPGO8LBxjebYU4=;
        b=EM6G4ihX8xf2YrcppINFkzjlSCj032hgWKJOpGtSx9nJhhO4ZD966bZn8j4tHmhRht
         hdiCocXPIy8IAiUNa0GEh4aCw/hvy/u6Wq+bxwNjW11FQJRi0r4drk5C9ofTL1WCjYN3
         RIw0bBmM+SGEaENYYbcJLEzsBDgEOsdFm2bUsc9IqnbQFuCGq6JEOzY1C3u6XiN8ogLf
         Zshpk4sgfhojIrbOSrK8UHb2FSCA9/Je//SXStC5qDYoVp26O8aJ8HzLH12V+jC3EGfy
         7t8xUF9DCwUuQQcV+9awhkqo5TJBnSxf/V+TNUPzUEbw4oulzdydcMbr5TIBaQyyO8HA
         dsmQ==
Received: by 10.180.93.136 with SMTP id cu8mr8817153wib.7.1352589581517; Sat,
 10 Nov 2012 15:19:41 -0800 (PST)
Received: by 10.194.25.195 with HTTP; Sat, 10 Nov 2012 15:19:21 -0800 (PST)
X-Gm-Message-State: ALoCoQkrDOxu8bgfqlncG8h/G1hRbw8h9CVbcaJU/RzvK8QCdVGofBmbcdzKNwlHBjZFM+U2c/qk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209313>

Hi all,

This is my first mail to the git mailing list. I have been following
the list for some time now and I would like to suggest moving the
reviews out of the mailing list, for example to a gerrit instance, I
believe it would improve the commits and the mailing list. I have a
filter on 'PATCH', but I feel I miss some of the discussion, and
things that I would be interested in.

I have spoken to Shawn Pearce (gerrit project lead, google) and he
said he is OK with hosting the gerrit instance.

I would like to hear your thoughts on this.

cheers,
-deniz
