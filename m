From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: Draft of Git Rev News edition 6
Date: Fri, 7 Aug 2015 02:03:01 +0200
Message-ID: <CAEcj5uVzGe=tKns_B3+Yh_w4wn+t52SfZcb1UqmroG5xpWqCqg@mail.gmail.com>
References: <CAEcj5uXXe19APhNaV6Kfm_3SNpRmFHToooo07T0_r6McJOrsaQ@mail.gmail.com>
	<xmqqfv4087b8.fsf@gitster.dls.corp.google.com>
	<CAEcj5uUmsV5xzONaahkEEp7R80_zunSAiwTE2UeSxdS6wo1xmg@mail.gmail.com>
	<CAEcj5uXJnZ+3R+CWoUnpqixrKiiWMQMVjq2YrXYd2brbP9URQg@mail.gmail.com>
	<CAHYJk3QkMM40_HA7MO-h9z8f69rsPLmuKt1bkR+iuz75A+uQZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Nicola Paolucci <nick@durdn.com>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 02:03:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNV7s-0006U4-RY
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 02:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbbHGADE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 20:03:04 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33849 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbbHGADC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 20:03:02 -0400
Received: by wicne3 with SMTP id ne3so41352015wic.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 17:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LnpnhPd1cgpf2wzsFEMBUZGaKrcbN+SEx1dX/8gfBnQ=;
        b=WuKqQidPFnq0XSQa2ERNQZ+KQxXI6hsSI6BQIFl6H81wTIR75oj2b1WH9Cafuio6Y0
         brErAIP7je2ZKb35xBITrWd+bZ8pE0K4eSjo/+8+HqfFv903s2oQRnzgA+tuAT3vlGm3
         O9rjpe1ySxGzO9y8nHD8ZbpO5xNVZaCmYMOBVhVWkw9ynEHx7AbW0xV5cjZal+NYyHaB
         MRCRv3HSDRZKYpdnjHEcTZ1of0WgKHPbeUqE3scQxL/SdHJOGV1bUPEMAROUS6RGjYnZ
         smIVoluut0EE5J1xlFZ0QM+88o8mEQ/pilBRtouvQ8iOEd/iQ3l+0rOEmPVayKKiYdDG
         NsXQ==
X-Received: by 10.194.179.37 with SMTP id dd5mr7102655wjc.129.1438905781202;
 Thu, 06 Aug 2015 17:03:01 -0700 (PDT)
Received: by 10.27.47.137 with HTTP; Thu, 6 Aug 2015 17:03:01 -0700 (PDT)
In-Reply-To: <CAHYJk3QkMM40_HA7MO-h9z8f69rsPLmuKt1bkR+iuz75A+uQZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275452>

On Fri, Aug 7, 2015 at 1:44 AM, Mikael Magnusson <mikachu@gmail.com> wrote:
> It is surprisingly difficult to get to the actual post of edition 6
> from this thread. The link in the original post is just a 404, and to
> get to it from the link in this mail, which you might not have sent at
> all, I had to click like 5 things, and a few of those turned out to be
> dead ends. I suppose once you know where they are published, it is
> easy to find, but I did not :).

Sorry about this. It's because at the time of publishing, we move the
draft into the CMS' (Jekyll) blogging directory, and as we have no
nice and easy way of making redirects in that system, the link ends up
dead.

The current live edition 6 is here:
http://git.github.io/rev_news/2015/08/05/edition-6/

The source page is now here:
https://github.com/git/git.github.io/blob/master/_posts/2015-08-05-edition-6.markdown

You can always find the latest published edition, as well as an
archive here: http://git.github.io/rev_news/

We'll make sure to include "fresh" links in our emails in the future.
