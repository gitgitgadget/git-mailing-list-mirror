From: fREW Schmidt <frioux@gmail.com>
Subject: Re: zealous git convert determined to set up git server
Date: Sat, 17 Sep 2011 16:04:27 -0500
Message-ID: <CADVrmKTdx6zJdzMmvtgmtBNVDrqi-y_2+6Z1haBC-y3GP9GbQw@mail.gmail.com>
References: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Joshua Stoutenburg <jehoshua02@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 17 23:04:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R524F-0002zs-Hq
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 23:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405Ab1IQVEs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Sep 2011 17:04:48 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39657 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab1IQVEr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Sep 2011 17:04:47 -0400
Received: by pzk1 with SMTP id 1so5920714pzk.1
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bV7H0JU1bqInRLo79j0dfLSyWHoT+AW71wMNkF6hf8c=;
        b=My3H1uT0GX6Od9xNaigd8Y2bWAI+vjoC71VIy2imlZNpmVTc3l2bA4MD4M2JDNS2ch
         hovtT+JCwDeMVmCYPO6Yve5UatrMp2GSEwm9M0fACcpu5lamLWtoIJ05q2g8C2Ju3nmN
         TKyYuQLZUQ1W6DGDHnNUAOdpwCe/IFrc9iyl4=
Received: by 10.68.24.36 with SMTP id r4mr1413022pbf.16.1316293487250; Sat, 17
 Sep 2011 14:04:47 -0700 (PDT)
Received: by 10.142.232.17 with HTTP; Sat, 17 Sep 2011 14:04:27 -0700 (PDT)
In-Reply-To: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181585>

> Question 2: It seems gitolite is the popular choice for git user
> management. =A0Any reason why?

Another thing that I personally LOVE as the "Version Control Czar" at
my company is the fact that users can easily get a list of repo's that
they have access to using gitolite.  Instead of people asking me all
the time "what's the name of the Foo repo?" they can just do `ssh
cesium info` and get a list of repos.

It's a small feature but it really is super handy.

--
fREW Schmidt
http://blog.afoolishmanifesto.com
