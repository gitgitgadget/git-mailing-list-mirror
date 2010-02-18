From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFD: best way to automatically rewrite a git DAG as a linear 
	history? [correction]
Date: Thu, 18 Feb 2010 13:41:28 +1100
Message-ID: <2cfc40321002171841y35b7132bt424b9e895763e941@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 03:41:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhwKf-0004zT-VL
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 03:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645Ab0BRCla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 21:41:30 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58633 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab0BRCl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 21:41:29 -0500
Received: by pwj8 with SMTP id 8so1337282pwj.19
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 18:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=YJdNP6NkqQmmgNyT5C0vttRSvSRhBVrf/Aq/naOBdWc=;
        b=MOO/4Lk1MNREVVIpj7TH2tm14QtIHy+IGdSyksgq0uaSuZtDWf2ESwAQfm58whIXxK
         STH6vL3xteU9qNgoXJqdkYAmHjhgNiBku+0LjaGzmYWocqz/IewqVbPy7Qa8NG/qdGh8
         F3dJsF7Aq2DtF07xxvsZP0hEz47IO8ikiR7UU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=KFVwx3GCYfwMeKplsI/IN2cK16vjoBHYFXHCHMScTdzNKYK472LX4h7N4deeBzPvqo
         yEshob2jcLBfLg3XfDvTsRRT9/9xdmbmNA68GpEyO8GGEwtujttBSfAJpcp5JfvpzuQ1
         hiaxDofpC5ZEmlpLFekJBjr56oOxgM+YaN1+o=
Received: by 10.115.85.15 with SMTP id n15mr5954236wal.172.1266460889014; Wed, 
	17 Feb 2010 18:41:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140291>

Of course I meant to say:

"I guess some might be sceptical that a sane automated rewrite is
_possible_, but I am insane enough to think it might actually be."
