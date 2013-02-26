From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Git 1.8.2 l10n round 3
Date: Tue, 26 Feb 2013 18:24:47 +0800
Message-ID: <CANYiYbGaO+gj0JAVyBa3bVdWacaE08o=uOFRBiiBfhrWa8HhEg@mail.gmail.com>
References: <CANYiYbHF1MAEcbhhf+PfawTzTxC06LFuZuccyeQUmtf8xXE8ig@mail.gmail.com>
	<CANYiYbHPtW0u80ojHt9xoADVS8S8mVkubb6dUDN_1uwkcTZTww@mail.gmail.com>
	<7v4nh0z3nr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 11:25:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAHim-00028a-5e
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 11:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362Ab3BZKYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 05:24:51 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35405 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab3BZKYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 05:24:50 -0500
Received: by mail-wi0-f173.google.com with SMTP id hq4so4614611wib.6
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 02:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=3reIdR8hcUeE3HoIp9NsQY4DzzvNlggqmsdXjO0NWGI=;
        b=C+gGFW/YanSG4omJIZiPgbEdp+DGyl6HexYFyJ/ARpTLGNhp2ADqcRQNJ4yZj8seV9
         cJ7DbrnFsex/iom6EiHqMR5sdoOVGLmWcPqhgzWYGHlsHZ8W/I41O9haelAorHwHMgHA
         Nv4ka6cdLraj2f2exKyiVfJzP4umEfu41cPeBqUGTlwpIgCC7JmDWP1OUSbq9By0y0Mh
         QKAnKknyNNGAcw47tbAYumKbWg9HExq9iV4SVba3PR0EVCgi1D9GQiyg5++fTyuT/ipK
         iFW4C6ODl/vIpmkXekAqvksZmvvXcmpiS+jxJT7d6foaeYY+itIKX7yKrrfHcjOIvrxR
         +kjg==
X-Received: by 10.194.76.237 with SMTP id n13mr25320386wjw.57.1361874288082;
 Tue, 26 Feb 2013 02:24:48 -0800 (PST)
Received: by 10.194.110.199 with HTTP; Tue, 26 Feb 2013 02:24:47 -0800 (PST)
In-Reply-To: <7v4nh0z3nr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217132>

Hi Junio,

Additional pull request for git 1.8.2 l10n round 3, which has
Germany translation updates.

The following changes since commit 4dac0679feaebbf6545daec14480cf6b94cb74ed:

  Git 1.8.2-rc1 (2013-02-25 09:03:26 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 5e93cd307bdb98809bb0aa3bfb2c0306131f3654:

  l10n: de.po: correct translation of "bisect" messages (2013-02-26
07:38:34 +0100)

----------------------------------------------------------------
Ralf Thielow (3):
      l10n: de.po: translate 35 new messages
      l10n: de.po: translate 5 new messages
      l10n: de.po: correct translation of "bisect" messages

 po/de.po | 1457 +++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 821 insertions(+), 636 deletions(-)

--
Jiang Xin
