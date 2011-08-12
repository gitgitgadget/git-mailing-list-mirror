From: Vecu BOSSEUR <vecu.bosseur@gmail.com>
Subject: Linux Kernel + GIT SCM
Date: Fri, 12 Aug 2011 15:27:30 +0200
Message-ID: <CACivvv1-UcZdOx+ThLuUkqwL=oy7aETckV+18Fpj_zoXkcXJWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 15:27:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrrlw-0003lF-P3
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 15:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229Ab1HLN1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 09:27:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41403 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab1HLN1b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 09:27:31 -0400
Received: by bke11 with SMTP id 11so1647218bke.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Oj97yb/sQNJxtjwXwNGiaIYINoW1tMk11vdoSD6fU9Q=;
        b=HfUF5om0yrC7MnDquR4nY+IGphvvHC2HFkwiYBwciZQ6fUs4P/s6uzxa0QeDuKm4pS
         H2pmStPwjMmGjum+q7+ku+IJrS+gpIbv6wTTW8vsP7cdNzAazqarlBbHttbdViAGIPjr
         RpCER90WDF00QLsHvcEWB5n51YlxvGmKZPKvk=
Received: by 10.204.10.75 with SMTP id o11mr356502bko.124.1313155650074; Fri,
 12 Aug 2011 06:27:30 -0700 (PDT)
Received: by 10.204.116.77 with HTTP; Fri, 12 Aug 2011 06:27:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179227>

Hello,

I need GIT SCM to allow me to suspend an operation and to resume it
later : initial cloning, synchronizing repositories, ...

I believed this was the purpose of the "GIT Sequencer" feature
developped at 2011 Google Summmer Of Code ; please, tell me if I
missed something.

And I would like to know whether "kernel.org" servers will support
this feature soon or not.

Answers much appreciated.

Sincerely,
Valentin QUEQUET
( vecu.bosseur@gmail.com )
