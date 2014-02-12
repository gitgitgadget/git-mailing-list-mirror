From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 1.9.0 round 2
Date: Wed, 12 Feb 2014 14:32:42 +0800
Message-ID: <CANYiYbHTqV5pGxNsp+qVkdTxxfR=mSm3WkavSPgAC7_M+uvbjg@mail.gmail.com>
References: <CANYiYbGV7aPd300Bwkm9yWAZR-crtk8Jk2TCckuGvkmrQGe+rQ@mail.gmail.com>
	<xmqqtxc6r809.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 07:32:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDTNJ-0003EK-EP
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 07:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbaBLGco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 01:32:44 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:49030 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaBLGco (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 01:32:44 -0500
Received: by mail-wi0-f178.google.com with SMTP id cc10so6179550wib.11
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 22:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FQbNxI/k9+qULhHcsTkaY/HHq/u4Wd6VSJTM09pyssM=;
        b=tAEV4hD/703kfOChDwuWHj8XAYT1wW3NbHlZkV330SqZ2uq3iXbr4NSWy+gBteHZqZ
         hyNI1PocS3cQMHoNdLuPxvyZeD7qRM0QZbR6lMXQvx4oh7RuaUDQOm7PsBctKSkAq8E0
         6K7t7kg83B8PpRI+rOTsWK+w7/9m8222+VbhMga9a3y4zoaLRYq58xljejIVKZs8ha+v
         YumSz08kSP/rSH+NZov1lL4Vq9IUmEaE5q8Y71OvK/eGBCRnP9NILqUHVesSN0wRNaF6
         uOrGavcPNIGF27s9W7A+B8Y6IPIH4h/jFK2YHAZpkmAaWkeEXufHnPv9cl3QRnojTQhV
         d5Hw==
X-Received: by 10.194.79.131 with SMTP id j3mr28308249wjx.17.1392186762674;
 Tue, 11 Feb 2014 22:32:42 -0800 (PST)
Received: by 10.194.71.162 with HTTP; Tue, 11 Feb 2014 22:32:42 -0800 (PST)
In-Reply-To: <xmqqtxc6r809.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241972>

Hi Junio,

Update window is still open? Here is l10n for German for your to pull.

The following changes since commit e265f1f7168a262c2f50c68707ff17318ebfdc5a:

  Merge git://github.com/git-l10n/git-po (2014-02-11 11:02:05 -0800)

are available in the git repository at:


  git://github.com/git-l10n/git-po master

for you to fetch changes up to 92cd3e35a0493fed026e5baec97e1e7359bcda96:

  l10n: de.po: correct message when hiding commits by craft
(2014-02-12 07:16:03 +0100)

----------------------------------------------------------------
Ralf Thielow (2):
      l10n: de.po: translate 28 new messages
      l10n: de.po: correct message when hiding commits by craft

 po/de.po | 1810 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 966 insertions(+), 844 deletions(-)

--
Jiang Xin
