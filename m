From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: [ANNOUNCE] GIT MinGW port is now at v1.5.3-rc4
Date: Thu, 16 Aug 2007 03:08:23 -0700
Message-ID: <6020F7321DB14F7B9288F0782A316803@ntdev.corp.microsoft.com>
References: <46C41C49.A92AEF07@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Johannes Sixt" <J.Sixt@eudaptics.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 16 12:08:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILcHL-0006Oa-HC
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 12:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760185AbXHPKIc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 06:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760228AbXHPKIc
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 06:08:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:36851 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758999AbXHPKIb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 06:08:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so230669wah
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 03:08:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=YfH4kNJ8A88GFQsQpmkvR9Xb8MglBnKBZzV1JKj2aLgSNsmAU5Kn6Ir3z3dc+ffN3Inv2EzvlljvufJRe8iY70R3ruTMhocgKyQB25rSCDE0OpL7ABAVGGs4EZt67fSWF4VlzW8P+v6QVAL8Ez9ImM2rnn0cJ7ILw/AY077Qr6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=SbqKTjs0wkz9uv9DLYUog8m1roJcmVquCM4JYrhZ2UiWS56ZlTqcaciiaw4puJ9WCUAedv2MBjWlcXh44BX1ZID8BDyBZnL8tCzmeF5WweQD7JkmiSeD5cA1qXxOEfdbm6AFw7msd/Hh8zneDyvJnP19dRTZPAdXP4lEyVEaaA8=
Received: by 10.114.194.1 with SMTP id r1mr855646waf.1187258911041;
        Thu, 16 Aug 2007 03:08:31 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id l28sm820898waf.2007.08.16.03.08.25
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Aug 2007 03:08:26 -0700 (PDT)
In-Reply-To: <46C41C49.A92AEF07@eudaptics.com>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56001>

----- Original Message ----- 
From: "Johannes Sixt" <J.Sixt@eudaptics.com>
> I've just pushed an update of the MinGW port to:
> clone:  git://repo.or.cz/git/mingw.git

We need to make sure that we don't duplicate our efforts.
Have you looked at http://repo.or.cz/w/git/mingw/4msysgit.git ?
We've made some progress while you were on vacation.

Also I think it's now time to merge two repos.
Two Johanneses (corresponding repo owners on the to: line), please coordinate with each other.

- Dmitry
