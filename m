From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Pseudonymous commits
Date: Thu, 25 Mar 2010 01:14:18 -0400
Message-ID: <32541b131003242214o2b05e5cbn1668872daea7e887@mail.gmail.com>
References: <4BAADF34.3080806@gmail.com> <4BA51E6B-7325-465A-B23E-7F3C5BF87700@mit.edu> 
	<4BAAE981.4040205@gmail.com> <e51f4f551003242154p7fb20ffch790dd1ada15eca0@mail.gmail.com> 
	<4BAAEDF7.1080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kris Shannon <kris@shannon.id.au>, git@vger.kernel.org
To: "Mike.lifeguard" <mike.lifeguard@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 06:14:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NufP3-0004w0-00
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 06:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab0CYFOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 01:14:39 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:53100 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab0CYFOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 01:14:38 -0400
Received: by yxe29 with SMTP id 29so383785yxe.4
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 22:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=y+kcSlNC29zrlXrapOpZs9VcMxsS1GRaIDMkDV52Eys=;
        b=mla/qztoW2Q6nD23IHBMh9GcFQiOuDphEQnoKHNk+iXwGfyqtris/IPi2biqlX49EH
         aQ21nsVLxllXgvouWZ5Z5rKHhUSWxNKmyUEWm8MpeTbgiE6jjSI2cnEzho+wbPCS1qvn
         9ShQUEfjsYviCTGo9s/sFfQ3r/LVfqivvJd1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=AmNnwHqhy3563YILs+g6+StoV7qBS7x5AMGhauB9maQjPwbpyUQkL2tKh+9DF+1ccP
         qk5w+XPjvYuOnryt6CQtQ8eZ2RX4XbChn1D4t9yGhj+66p6XFCChNplXpaCfBnTgeKbD
         B2SPbVG8yWDTuGZ3+hZomN308yuFKkURIhyiA=
Received: by 10.151.148.17 with HTTP; Wed, 24 Mar 2010 22:14:18 -0700 (PDT)
In-Reply-To: <4BAAEDF7.1080107@gmail.com>
Received: by 10.150.81.2 with SMTP id e2mr658357ybb.173.1269494078110; Wed, 24 
	Mar 2010 22:14:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143159>

On Thu, Mar 25, 2010 at 1:00 AM, Mike.lifeguard
<mike.lifeguard@gmail.com> wrote:
> On 10-03-25 01:54 AM, Kris Shannon wrote:
>> Accountability for translations is even more important because review is
>> usually a LOT harder.
>
> I didn't say the translations weren't reviewed, or the translators were
> unaccountable. They are in both cases.

I think the point is that if you don't even have contact information
for them, they can't *really* be accountable.  But of course that's up
to you.

> In any case, is the answer "git can't do that" or not? Because that's
> actually the answer I'm interested in.

Every committer (and author) in git has a (nonempty, I think) name and
an email address, and that's how you identify the committer (and
author).  What you do with those fields is between you and your
project maintainer.

Have fun,

Avery
