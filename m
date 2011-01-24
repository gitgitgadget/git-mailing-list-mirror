From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/3] git-gui: spelling fixes in russian translation
Date: Mon, 24 Jan 2011 21:06:41 +0100
Message-ID: <AANLkTinZCegWW-6uQ++uO9fGQ4SQ34=W4TJXW6ii5jXD@mail.gmail.com>
References: <cover.1295295897.git.raa.lkml@gmail.com>
	<1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com>
	<20110117210828.GC27029@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 24 21:06:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhSgb-0002GV-BY
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 21:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448Ab1AXUGo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jan 2011 15:06:44 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53514 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab1AXUGn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jan 2011 15:06:43 -0500
Received: by bwz15 with SMTP id 15so3931389bwz.19
        for <git@vger.kernel.org>; Mon, 24 Jan 2011 12:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QQLdubJKjX5lUrexiLmg+RO1uF/i59ph2L4FG0C2p7c=;
        b=Ggf60GgC1tYi1GoQQwRj+WmwBakSSWSUoXXNVSNZAtgIU1NPBNSbtE/mqTyEErrqOf
         PSrTzLukW/e7FumFgAVlgEhQVgP+WjGzsrAdmKsAprdGM7Jo29GxxT+q2Rfb7M07CT9S
         FpWGNtUcuOTeNQJl2CNRke4mC7HqDxPnkMag0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OvMHXPzRMAssiVjwJmcIHm5d1QSOrwMEBYC3iLFUKDwlFrBbuPG+hiywq1/brrkHYk
         rts/ZW+asdN4Z02XWzyBKYrix0oWoPQqxYsjrc0flIKvRkXVcdqoxxupVzeO4z/8MEwj
         oRUq/b4ByvHnKkOk3l//Yw3oomHDIAfmQY/cM=
Received: by 10.204.118.138 with SMTP id v10mr4212009bkq.94.1295899601847;
 Mon, 24 Jan 2011 12:06:41 -0800 (PST)
Received: by 10.204.102.14 with HTTP; Mon, 24 Jan 2011 12:06:41 -0800 (PST)
In-Reply-To: <20110117210828.GC27029@blimp.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165455>

2011/1/17 Alex Riesen <raa.lkml@gmail.com>:
> =C2=A0po/ru.po | =C2=A0 24 ++++++++++++------------
> =C2=A01 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/po/ru.po b/po/ru.po
> index c15bdfa..304bb3a 100644

BTW, does anyone know what happens to git-gui development?
In particular, the i18n patches. The old way of pushing
to a mob branch seems to stopped working, and anyway, the
branch is very out of date.

Is git gui development stalled? Should I perhaps send the
i18n pull request directly to Junio?
