From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Fri, 14 Jun 2013 11:48:10 +0200
Message-ID: <CAP8UFD2ebaS+POPxTcKZtZhnMRD9-nOT=zr6Q_WKk9Wc8JVtUQ@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<20130613101856.GA11034@workstation.dev.smoothwall.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 11:48:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnQcE-0008Nm-0H
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 11:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab3FNJsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 05:48:14 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:41299 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab3FNJsN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 05:48:13 -0400
Received: by mail-ve0-f175.google.com with SMTP id da11so288855veb.6
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EGwV5YMRhtZ6YJ7VOhTEMd62EkH0ldW0zH0Y4TNI1kA=;
        b=UdVZ7JDRfKDste7h/5SAJUZ8Dcz3OtWVWIvfSHIyiOh/YLv2zK3AcUyx/NStGMYE+5
         /vWuSyoP1Xs4tCZMGMVNvPYigTEYmv7G/bwj8kNhhvsL/1tul6HKTp++NmhN2eOeKMci
         tqPyAPsOwppAfDhaw2Wo5Lhw4hC5pAeJIb0vsE8i8ljkbgj1vZb0QYMedFgYKxPJaUV+
         TrLdpEECPVt4aIPa26gO+/PXTWIlRa0yC3pDh6dlFQ2MG4/ooeBiz8t6YCT0synnG/OY
         g0zLg004hQTP5f3Qi8ULtfSIwjSt6o3aYNaFv5BCkOjpMaVLahya/6muv+sRfAugTWQ7
         K7Ig==
X-Received: by 10.220.73.135 with SMTP id q7mr632901vcj.33.1371203290424; Fri,
 14 Jun 2013 02:48:10 -0700 (PDT)
Received: by 10.58.169.103 with HTTP; Fri, 14 Jun 2013 02:48:10 -0700 (PDT)
In-Reply-To: <20130613101856.GA11034@workstation.dev.smoothwall.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227801>

Hi,

On Thu, Jun 13, 2013 at 12:19 PM, Thomas Adam <thomas@xteddy.org> wrote:
>
> So these guidelines gain the community nothing, and only serve to punish
> those who are already following them, without them being written down,
> because the root-cause of the problem is still here, and isn't going to go
> away, no matter how much referring to these guidelines might help.
>
> That is why I think this is the wrong thing to do.

I don't know if some guidelines will gain the community anything, but
there might be another solution to the current problems in the
community along the following lines:

- decide that later this year (for example next october or september)
there could be a developer
meeting/conference/merge/gittogether/whatever somewhere in North
America

- ask many developers who contributed to Git significantly, including
those involved in the last flamewars, if they could come and if they
would need financial help to come

- ask some companies to sponsor the meeting by providing money, space,
food, beer, accomodation, whatever they want

- maybe ask Git developers or users living neer the meeting place if
the developers coming could crash at their place

- announce the meeting, thanks the sponsors, by the way thanks a lot
GitHub for the git merge 2013 last May in Berlin

- meet, discuss stuff, have a lot of beers together, write stupid joke
patches together and send them to the list

- reimburse the developers who came for their travel and if needed
accomodation expenses

- thank everyone for coming and having a good time together and thank
the sponsors again, by the way thank you guys who came to the git
merge 2013 and thank you again Github, for organizing it and Uber and
Google for sponsoring it

It might not work but it might be a nice try :-)

Thanks,
Christian.
