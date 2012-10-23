From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git merge man page, upstream
Date: Tue, 23 Oct 2012 11:07:15 +0200
Message-ID: <CAB9Jk9CEbT=Y=yjw2tPSLiLibejDSheabcBPEpHCLa_TS+6Cpw@mail.gmail.com>
References: <CAB9Jk9BT3F1_yvf7jQQyT72_EWskFS4bEgXCkmJs7uZOPhEK8w@mail.gmail.com>
	<vpqk3uhr5gp.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 23 11:07:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQaST-0000fe-Jr
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 11:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805Ab2JWJHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 05:07:17 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:48049 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756707Ab2JWJHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 05:07:16 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1831082dak.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 02:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bqU+2WN2H1Moo7BVaH6vd/+dRuFRwd7UNT0UBrWrdUo=;
        b=xV237vV9VHDP8r4tgcTm3f8Ehai0tYJjlSxXmmmz3U6UKOysxM/ucMB8PghOaWeob6
         tvP9xG8ir8gsBbFz4/U9fjob0GMsT90r/4BS2o626YrmnXxYMGcAIOIal349shKOAvum
         y0lVMibpO4TBk6IaZMfLpdol3ZFOVWkbyOp426d3ij13YzA6pdtxqFdlKnOkF/xx+c0J
         I39BlgrEVjUhiwsMdj3Fl2cIjyo0Nc+T3zmJZ4M/KhkR/J7qWswrkfdblbKzmOVvc6Ei
         zyEQ867Zd6mQCs5oteZgfOI2y0OtrsDkbzpQ8VC0AZ845FKir15vq7SAzZlM31cweG8C
         EmQQ==
Received: by 10.66.76.98 with SMTP id j2mr33209591paw.65.1350983235758; Tue,
 23 Oct 2012 02:07:15 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Tue, 23 Oct 2012 02:07:15 -0700 (PDT)
In-Reply-To: <vpqk3uhr5gp.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208218>

Hi Matthieu,

the upstream branch can also be a local branch.

-Angelo
