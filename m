From: Petr Onderka <gsvick@gmail.com>
Subject: Git documentation at kernel.org
Date: Tue, 7 Feb 2012 13:28:14 +0100
Message-ID: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 13:29:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RukAN-0001Ij-NM
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 13:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab2BGM2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 07:28:55 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44811 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697Ab2BGM2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 07:28:54 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so350431dae.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 04:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Ax0G8+JtjPyn3T0m68EJe6sDlhAYYb8/oE6eeEJMrZQ=;
        b=so9ana9cAbU28Y433OgDAkn/gJyj1RZ2vzgbbIKwxRuIimJfRNBHzE+hq7VFmtRRfT
         R3emZU/svB1nDZE2K7tDpYebgW4koCxF5Nln6dj3WDznoJFi0ryhPQNqDlFx7SBnhmjh
         AsM8FeRTJDrqZLewfTV1lQBZDoiWohRd3FhDw=
Received: by 10.68.75.136 with SMTP id c8mr57419316pbw.113.1328617734126; Tue,
 07 Feb 2012 04:28:54 -0800 (PST)
Received: by 10.68.51.69 with HTTP; Tue, 7 Feb 2012 04:28:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190163>

Hi,

since the hacking of kernel.org, the online version of git
documentation [1] is not available. I realize that I can use local
version of the documentation and there is also at least one mirror
[2]. But I think it's very useful to have an "official" version of the
documentation online. And, more importantly, there is now lots of dead
links all over the Internet to the kernel.org version of the
documentation.

Can someone with the ability to do so restore the documentation at the
old location?

Thanks.

Petr Onderka

[1]: http://www.kernel.org/pub/software/scm/git/docs/git.html
[2]: http://schacon.github.com/git/git.html
