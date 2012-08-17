From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.7.12-rc3
Date: Fri, 17 Aug 2012 09:58:54 +0800
Message-ID: <CANYiYbEW921OAjFuTbT1tOz6Fow3_vVAsjDK52A-Hp=60+VTyQ@mail.gmail.com>
References: <7v1uj74uaq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 03:59:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Bq1-0004Op-Nx
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 03:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424Ab2HQB64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 21:58:56 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53929 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932226Ab2HQB6z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 21:58:55 -0400
Received: by yenl14 with SMTP id l14so3607439yen.19
        for <git@vger.kernel.org>; Thu, 16 Aug 2012 18:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OothcUb7p2wxCHvcbRGiEBDT0ZJVPl/txcD00B/uiEg=;
        b=WXGmeFaDcRrLHT82ixe8EJLTwAfpDsAgJu6qO2/luFBcnlCN4rKozYLURvENVJ037D
         /BAySMxYqZm6C6rJGOko3eaecvrcJGBH8Dc3H9wR3quPDODQpPjf/7V4iFZICsssZoIB
         shmP/jJpV65Nlpcj01KNF+XuXzKZaaHZScquy3o52hpTSEt+trFEGubhfGcO161ztvfq
         Pkerk0XYifKninU/SxlaCHps+K7tLib5ZqYxjkJMHd85WHh+Ni6BhNUFn0YtLTZUO71d
         ut5NJdabfDPmEB3/eq+or7hc6rtBQATQjzK212hQEPYrxYVXMIARaEoWMuGZEgdK3AWA
         QPjw==
Received: by 10.50.187.233 with SMTP id fv9mr188565igc.59.1345168734733; Thu,
 16 Aug 2012 18:58:54 -0700 (PDT)
Received: by 10.50.17.104 with HTTP; Thu, 16 Aug 2012 18:58:54 -0700 (PDT)
In-Reply-To: <7v1uj74uaq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

There is one commit on Swedish translation, and it can be added to the
final 1.7.12 release.

The following changes since commit 61b472ed8b090a3e9240590c85041120a54dd268:

  git svn: reset invalidates the memoized mergeinfo caches (2012-08-10
19:53:18 +0000)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 5b8056c1552a18e289f185f57b86a4b05253716d:

  l10n: Fixes to Swedish translation (2012-08-16 13:57:51 +0100)

----------------------------------------------------------------
Peter Krefting (1):
      l10n: Fixes to Swedish translation

 po/sv.po | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
