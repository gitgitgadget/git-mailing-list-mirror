From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: Our official home page and logo for the Git project
Date: Wed, 09 Apr 2014 11:43:30 -0500
Message-ID: <534578b2e22e2_af197d3081@nysa.notmuch>
References: <xmqq7g6z4q6b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 18:57:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXvoO-0007Dc-Nl
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 18:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933898AbaDIQ5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 12:57:14 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:40546 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933424AbaDIQ5M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 12:57:12 -0400
Received: by mail-oa0-f45.google.com with SMTP id eb12so3031445oac.4
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=+c5ff9iaJ15E9kbBt7Y9L8rOnDk2UnyODgNcHduKvqs=;
        b=P2Blikak44p7hnu4zwhXLgeh79TPonE3NRIQWYA87qvLFoXHm5zB/4xpw00IapIO67
         s0O8kkq37DVvhkiqqaf1gs1GiCByMQ6HjgTm4+CXLHGdK/6+p72Eu+1g9mKFVCar3b8a
         U43RxLrDkSudz3r0Rj4s1+NUwRc4juOHiTcW7r8EQ6vHGixnmh+cTm+1Qe3Dp4tRA1vb
         ngexZbj6TygXWSwTnbtc19eVMLH/YNR06Vswe3YZWhfpE0TRHa27LLgbuW4zr5ucYWhD
         BVdqNG2VwvzHdYJI2W9Ivawg7JizPhZA2IiEBGXB5aDewo3HbQBfRpls4n0gOveMtOY4
         0Xdg==
X-Received: by 10.60.115.68 with SMTP id jm4mr2724408oeb.57.1397062632234;
        Wed, 09 Apr 2014 09:57:12 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d9sm6089123oex.6.2014.04.09.09.57.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Apr 2014 09:57:11 -0700 (PDT)
In-Reply-To: <xmqq7g6z4q6b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245980>

Junio C Hamano wrote:
>  - To officially adopt the logo that appears on the "project
>    home page" as our "project logo".

I have made my objections to that logo before, but here it goes again: bright
red is a horrible color for a logo, as it only looks good in limited
situations. I propose you use the logo I chose for git-fc[1] which has a better
color, and instead of showing commits going down, they go up.

Here[2] you can see how horrible contrast this brigth red makes.

[1] http://felipec.files.wordpress.com/2013/10/git-fc2.png
[2] http://felipec.org/contrast.png

-- 
Felipe Contreras
