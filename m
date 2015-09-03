From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GSoC 2015 is over
Date: Thu, 3 Sep 2015 11:49:58 +0200
Message-ID: <CAP8UFD0+6ETC4D2+x=bMn-2TNexJhYDW39Z1_DtvWjQGET8pyg@mail.gmail.com>
References: <vpq8u8qw047.fsf@anie.imag.fr>
	<CACRoPnTrvD2NFQopg2rJB_PSZv0tawRjiuVi8vK+YN0OyFh-sg@mail.gmail.com>
	<alpine.DEB.1.00.1509030042100.16897@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 03 11:50:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXR9e-0007U0-Vp
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 11:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbbICJt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 05:49:59 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36656 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbbICJt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 05:49:59 -0400
Received: by ioii196 with SMTP id i196so51428472ioi.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=W9Ak1Hqj54Z37Nhf6B0017stBBAasD15afKCPzW8gd4=;
        b=lPiKb6Xc9lBtlNFnGBdjNoO3ezUqKesazZyHH+RxKuZEvsRMTk6fpQT03uhBauNMIj
         pam1VE1qXMXY3gbjebf7YZWMv3Ab/vCKuSdk/1Jw324oX4bTIXcwzPzb2tfViF3dlKa7
         T4SRU+CPYXHbSgAijgg466fnJKWElkYsJFOdPXDp+s95KrjS7Qy5bjDjVfxY4gEY29T4
         8i28N39yAOic48UcZI3LYflGHqE921HXKlE+jB/ntw54X3PNshEVHYcmivT/QiAkDjFG
         uJNCsFr2pqOCkuXCjom7LcFXIMNDiEq6e5M3HjUfIhC9VR3WUKt22Wb/3IPaKkRqpMOi
         aFKg==
X-Received: by 10.107.14.84 with SMTP id 81mr49163075ioo.195.1441273798473;
 Thu, 03 Sep 2015 02:49:58 -0700 (PDT)
Received: by 10.79.93.131 with HTTP; Thu, 3 Sep 2015 02:49:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1509030042100.16897@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277193>

Hi,

On Thu, Sep 3, 2015 at 12:46 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 2 Sep 2015, Paul Tan wrote:
>
>> On Wed, Sep 2, 2015 at 12:55 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> > I consider this GSoC as a great success and a pleasant experience.
>> > Congratulation to Paul and Karthik, and a warm "thank you" to everybody
>> > who contributed: administrators, mentors, reviewers, and obviously
>> > Junio! (not to mention Google, who made all this possible)
>> >
>> > Thanks all!
>>
>> Thanks!
>
> Well, with so many thankyous going on, who am I to hide behind a rock?

Yeah, not to hide behind a rock myself either, I will say that I agree
Karthik's GSoC has been a great success, thanks to everyone involved
especially Karthik who has been very responsive and very persistant,
Matthieu who has been a great co-mentor, a great reviewer and a great
admin, and Eric, Michael and Junio who have been great reviewers of
Karthik's work.

I also feel very lucky to be the Git project mentor who will go to the
GSoC mentor summit on November 6 & 7. Thanks!

By the way while in the Bay Area from October 31 to November 14 it
would be nice for me to meet some Git developers living there. As Peff
suggested we could even have a mini GitTogether if enough developers
are interested. It doesn't need to be big. It could be just a lunch or
diner. Tell me if you are interested. We will see depending on the
number of people interested what we can do.

Thanks,
Christian.
