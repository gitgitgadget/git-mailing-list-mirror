From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Splitting the mailing list up
Date: Sat, 2 Oct 2010 16:33:04 -0500
Message-ID: <AANLkTi=WRfbAa7Xb8PS63_DfKiZYwEsWSruivwtkVhWR@mail.gmail.com>
References: <20100925230022.6e2fd389.coolzone@it.dk>
	<4CA1899F.2020509@cadifra.com>
	<141CAFB5-D423-48FE-BEED-B755C5F2685B@sb.org>
	<4CA2FA76.6080501@cadifra.com>
	<4CA30201.5020006@drmicha.warpmail.net>
	<AANLkTimPdqM_29Aru7tAGp_REem+BYAuE8o-U-qkhS6T@mail.gmail.com>
	<AANLkTim2Zrj+VUirUL+cyfFnHRw6L9TST-p01yx1rtZS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kusmabite@gmail.com, Michael J Gruber <git@drmicha.warpmail.net>,
	Adrian Buehlmann <adrian@cadifra.com>,
	Kevin Ballard <kevin@sb.org>, Rico Secada <coolzone@it.dk>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 23:33:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P29hy-0002zJ-EW
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 23:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202Ab0JBVdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 17:33:13 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33998 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab0JBVdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 17:33:12 -0400
Received: by qyk36 with SMTP id 36so1084920qyk.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=nzL6kyS0J7pYDN/QTEi7HbcQSc5DMBS7Z9GZgN4JbRo=;
        b=GaxN5ZPE97yE5miocNqAXkkl1Bvq2gJWd4W62QrL08QcMtT6S7MfXjBo00Gldj4aeQ
         GmfygBdE5ahCq18l4bnrxedPOl0cGzvczTwOhfXvykNc/Kk5w2T47n570xUfpuCxDPtj
         FJ4KejEVeGOUD97SlYNqn45kYDtIQiXFs7QgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pUz6bXsGgC9TR0KK/z9Hg5MUGi5ak2m1m/CNd1f2R5/mEGNnsh1DGIYZrI1FoNyd/e
         2WKAwHeUE+bzJYlWQH4aeHgjzBUzH0dLF76ra6A1nIpM8whiYfBbKWTvoCc7Ako+CYA2
         oniGQpqyb8MgKhFGfekocMS0tpXYX0oLjwRK4=
Received: by 10.220.63.136 with SMTP id b8mr1896499vci.175.1286055184779; Sat,
 02 Oct 2010 14:33:04 -0700 (PDT)
Received: by 10.220.203.3 with HTTP; Sat, 2 Oct 2010 14:33:04 -0700 (PDT)
In-Reply-To: <AANLkTim2Zrj+VUirUL+cyfFnHRw6L9TST-p01yx1rtZS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157814>

On Wed, Sep 29, 2010 at 10:02 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Wed, Sep 29, 2010 at 15:00, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> http://groups.google.com/group/git-users says "This is the git mailing
>> list for users, feel free to ask any question about git usage.", so
>> yes. I think we already have that list. Perhaps all we need to do is
>> to add a link to it on the front-page of git-scm.com, next to the link
>> to this? Perhaps something like "You can also ask the Git development
>> community directly at our git@vger.kernel.org mailing list, or the Git
>> user community at git-users@googlegroups.com"?
>>
>> That would imply making it a bit more official, but perhaps it's a
>> good compromise?
>
> Perhaps we can just at 'git@vger.kernel.org' as one of the list users,
> so that all mails sent to git-users@googlegroups.com are forwarded to
> the git list? As long as the git-users group is open to all, that
> should Just Work, no?

If it worked, it would be just like the zsh mailing list setup that was
suggested, which is a good thing IMHO.

If gmane is to be trusted (and if I parsed the output of:

   http://gmane.org/output-rate.php?group=gmane.comp.version-control.git

correclty), then the git mailing list has received an average of about
80 messages per day in 2010.

The "about" page for the git-users group seems to indicate that the
group has received about 65 messages per _month_ over the last
4 higher-traffic-than-normal months.  A drop in the bucket compared
to the main mailing list.

But, the "about" page here:

   http://groups.google.com/group/git-users/about

also says:

   "Only members can post"

That would need to be opened up so that non-members from the
main git list could reply to posts originating from the "users"
group.

-Brandon
