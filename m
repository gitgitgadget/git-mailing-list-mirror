From: Sebastien Douche <sdouche@gmail.com>
Subject: Git roadmap (How read What's cooking in git.git)
Date: Tue, 16 Nov 2010 13:53:01 +0100
Message-ID: <AANLkTimtUz3L0F_iOpH7YuYpyoutPqtevPj-Tjo6MRcs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 13:54:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIL31-0004ii-Ke
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 13:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758086Ab0KPMxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 07:53:45 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33757 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757975Ab0KPMxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 07:53:43 -0500
Received: by iwn35 with SMTP id 35so777237iwn.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 04:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=Ku9UtHdPZ/2IYSXGuz2HMrk4p+vwn8QBGems8dUAGHg=;
        b=IhJZBZFRS2FmvheKVG2d/jzyAVyIPuvAk/9of/KS3ukz4XEKLJ7dv7aZUBMWU/kOq6
         3c2Ng6n7mfrUm4JSNYKQI8M73Nwb7Y87jPkg4Uf50LhHBFGj2USnta7pGOlch2equ8y0
         mdehDrTQ4WoowqoXN3H4sFJJvfLlk2tZtAdb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=G7GELHsV9qG39VBZ4v0R14+uTxolHQQv3xnRKJnkPcBAe6aLsyVAmkCy7N0XpqIR9J
         Q2BrQ98LOfwJOxrI6C9VQ3VpOTxBlZvkXXJbz9+VsTYuEv6AtbjR5/oFLoQIHIZs5XlI
         ssvMGce31CnnjfAebD0rQ7++qwq9l2c1epcVM=
Received: by 10.231.14.140 with SMTP id g12mr5542826iba.84.1289912022265; Tue,
 16 Nov 2010 04:53:42 -0800 (PST)
Received: by 10.231.174.20 with HTTP; Tue, 16 Nov 2010 04:53:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161560>

Hi Junio,
I'm starting a french blog[1] on git to support workshops[2]. The goal
is to explain deeply the philosophy, the commands and subcommands,
workflows, etc. And also to aggregate headlines of the git world,
follow events and announce git releases. For the latter, it's a bit
hard (for a non core developer) to follow the development. From your
point of view, how we could set up a roadmap and a "what's new"?



[1] http://blog.gitfr.net
[2] 100% free, with 50 attendees for the first workshop, 70 for the second!


-- 
Sebastien Douche <sdouche@gmail.com>
Twitter: @sdouche (agile, lean, python, git, open source)
