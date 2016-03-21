From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for 2.8.0 round 3
Date: Sun, 20 Mar 2016 20:33:34 -0700
Message-ID: <CAPc5daWam3xJCMJwmwGLtGbOHvWgH6sU0go+3Vg9zi2_acWTXA@mail.gmail.com>
References: <CANYiYbGCLE5xrNYPjvTfp9cho8ccb3xuNv0kMaFVt8jkmHfd_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Changwoo Ryu <cwryu@debian.org>,
	Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 04:34:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahqbR-0002Gp-Om
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 04:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbcCUDd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 23:33:56 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35960 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbcCUDdz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 23:33:55 -0400
Received: by mail-yw0-f196.google.com with SMTP id p65so16317280ywb.3
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 20:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=y4EUmmrw1StpLBd00XglimZwW/y+Nmg50g6XIztwko0=;
        b=Ax/f7K01vKfRV2OmnqB4xgmdLRkahTeqAslvS5gZBb7e/L00tUmM7ubwWOFlN9jgqZ
         tWUqrLvxy7QDlsTT3fyDbv8pcfZ+Z1A1RL2obl85E1SaR7XOAywJSmICPMSjrtlDnhiE
         fKsV2fu898mBLWXqIIgigMZN4fBVQNgQoB9i3ean7qlw/axRGCoDNzoAURJvDH9cFjBe
         JUAxzKnU+L01z267esBPpW10zB2f8qWeop+S3Nj0OWKMfNT7C7jQLMK07GiJdVLDz396
         8X2MlXRXK5xgKkpd2ByRged2vjj+FseoPQ0uHxL6akeqIRV9EIvqwNEvNA0WFPXNa4wf
         MnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=y4EUmmrw1StpLBd00XglimZwW/y+Nmg50g6XIztwko0=;
        b=PRacG3rSo4+tF7szX817US/7IG8toynW0dXgMq840aOdmR7dZFJRJ+XiJi8PhlI5Ia
         UYcEc1bN1BC4TYpT6HAakJ6TZqez8caaQGxM8JFg1EeikLPK/3TXRia16ogk33ILNKvQ
         PPPchRBFkrlJkNgaYSpUjDE30gnHVkyxASZbWSX1gZ6B5g6K09Plr8Yzlc2MgobBnAKJ
         G8IGTnYAUnvFUD/gy8UruMuDussVyXnkp9SmRrZNo6yCRs/+CVI/6YwJYXQyeeBPNzfP
         q/EkKW4TM+0YnkKrNFItntd4iyickBcwSEpfWRvZtjSVd3l+rYRzTs4wNJB1WJ8bNEZd
         idJw==
X-Gm-Message-State: AD7BkJKOH3xPMNwVCZhWzaPmm3C1w0W980tQJoqV6MciI3o/3deVOCx4XaB+HigCO+QyyY3S8BMbkiLvPo+ODg==
X-Received: by 10.13.245.135 with SMTP id e129mr14421187ywf.106.1458531234358;
 Sun, 20 Mar 2016 20:33:54 -0700 (PDT)
Received: by 10.13.219.14 with HTTP; Sun, 20 Mar 2016 20:33:34 -0700 (PDT)
In-Reply-To: <CANYiYbGCLE5xrNYPjvTfp9cho8ccb3xuNv0kMaFVt8jkmHfd_A@mail.gmail.com>
X-Google-Sender-Auth: wTnNsUktxpwMgJlK9YNbWdohLvY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289395>

Thanks.

On Sun, Mar 20, 2016 at 4:08 AM, Jiang Xin <worldhello.net@gmail.com> wrote:
> Hi Junio,
>
> The following changes since commit 5c0c220c53823e2a9ebe8e566e649ca30cd7e8e0:
>
>   l10n: zh_CN: for git v2.8.0 l10n round 3 (2016-03-16 00:27:40 +0800)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po tags/l10n-2.8.0-rnd3
>
> for you to fetch changes up to 26e4cbec4558ea21cd572bfc915a462f63c1ebb4:
>
>   l10n: zh_CN: review for git v2.8.0 l10n round 2 (2016-03-20 18:46:02 +0800)
>
> ----------------------------------------------------------------
> l10n-2.8.0-rnd3
>
> ----------------------------------------------------------------
> Changwoo Ryu (1):
>       l10n: ko.po: Update Korean translation
>
> Dimitriy Ryazantcev (1):
>       l10n: ru.po: update Russian translation
>
> Jean-Noel Avila (1):
>       l10n: fr.po v2.8.0 round 3
>
> Jiang Xin (3):
>       Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
>       Merge branch 'ko/merge-l10n' of https://github.com/changwoo/git-l10n-ko
>       Merge branch 'fr_v2.8.0_r3' of git://github.com/jnavila/git
>
> Peter Krefting (1):
>       l10n: sv.po: Update Swedish translation (2530t0f0u)
>
> Ralf Thielow (2):
>       l10n: de.po: translate 22 new messages
>       l10n: de.po: add missing newlines
>
> Ray Chen (1):
>       l10n: zh_CN: review for git v2.8.0 l10n round 2
>
>  po/de.po    | 172 +++++++++++++++++++++++++++++++++++++++++++++++-------------
>  po/fr.po    |  12 +++--
>  po/ko.po    |  10 ++--
>  po/ru.po    |   8 ++-
>  po/sv.po    | 153 ++++++++++++++++++++++++++++++++++++++++++-----------
>  po/zh_CN.po |  10 ++--
>  6 files changed, 283 insertions(+), 82 deletions(-)
>
> --
> Jiang Xin
