From: Chris Patti <cpatti@gmail.com>
Subject: Has anyone written a hook to block fast forward merges to a branch?
Date: Wed, 21 Mar 2012 14:22:46 -0400
Message-ID: <CAJ8P3RCQjh1ehjsihAmu8roC1aeRo=R0sN2Wm0Y4bVk=st4ivw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 19:22:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAQBS-0003bW-86
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 19:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759853Ab2CUSWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 14:22:48 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63035 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab2CUSWs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 14:22:48 -0400
Received: by eekc41 with SMTP id c41so469386eek.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=k3TNINvyQo1L9dcsr6JuWVabeoVb+8xLOYUXCp+LyNs=;
        b=sjXu2+V712xjGGiQ5tM0cwRN46atOfzKHSOU6HNM/x+9P5fWKEuNj7WU3M5bmDyD8q
         azuuwzbR7i7RQ/rFzYnCtTuM7HYW0Jdg1YJKIIJEagUNg+ozo0VwqF0GnvABzeyNMcL7
         MYwhfhAtopyFx4tmawZh111Av7muU8KVEhSCUYkcwMcuSOUTZLeXKyeKG+PYDLBQRlid
         F6ua26L0hhfUMiIeuiS8jPbnXrGIotGgiC4f/kAy/3VH8FYqK3VRjj+vSVAxWgXWk+ym
         AyghLlbFEmpxtUPBEkJ2Eg5Xj1WokhgdTviFfpZA+A5epiunERG/+vXyxovMooKjZHx3
         V7AQ==
Received: by 10.213.19.129 with SMTP id a1mr331960ebb.228.1332354166371; Wed,
 21 Mar 2012 11:22:46 -0700 (PDT)
Received: by 10.213.112.131 with HTTP; Wed, 21 Mar 2012 11:22:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193596>

I know there are hooks out there to block various other kinds of
change, but I was wondering if anyone had specifically ever written
one to block fast forward merges.

Thanks,
-Chris


-- 
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, Pixar
