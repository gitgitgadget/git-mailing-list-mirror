From: "Jhoola K.G" <jhoola.kg@gmail.com>
Subject: [Gitweb] - Hide Spurious entries
Date: Fri, 20 Nov 2015 17:35:00 +0800
Message-ID: <CANVt_SJXA7YmfNJZJ-pjT+3No=SVjfx6T7o8LsXNV1a0T_AQ9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 10:35:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzi62-0004Iy-Gt
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 10:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbbKTJfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 04:35:03 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35310 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbbKTJfB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 04:35:01 -0500
Received: by qkao63 with SMTP id o63so34541882qka.2
        for <git@vger.kernel.org>; Fri, 20 Nov 2015 01:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=yBuA6PMMQUKD3FWrTDlTa5zgfKQTd1bofSeChqUVry8=;
        b=ccsvvPc6xtUl2ELvK4KrkOySyM5ak4S63ZEC+ARSMgz0sbRLahiIAtt0sV3GLCBkpV
         bNVQKkKj+XYbybU4vzt8DAU1BnNW9jgLraHWVEnE81+RNssVHr2Ywr/LGa9Iv07OFyLt
         XuMurI8Y9rs19J9bxfGXPLG/WBciOJgBwnTbhoTCb6tXwa1ksZun0fva0Z0PlAjOqnuG
         TX+9T8Y7N1gUFS7AAedGyO36ITENgKi0grxdeiEdHyQ3SRLThwroW8qVA2NwVhogVlRr
         vw+GVD6IxH49+Yq02LyRbrE+peGTnbu97CFIlMwnn7isqxTmby1OQI+bu0RQxOX0FgYu
         QJyg==
X-Received: by 10.55.72.85 with SMTP id v82mr5847395qka.52.1448012100841; Fri,
 20 Nov 2015 01:35:00 -0800 (PST)
Received: by 10.55.221.200 with HTTP; Fri, 20 Nov 2015 01:35:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281501>

Hi,

Is there any better way to exclude gitweb from traversing into ".repo"
directory of my repository apart from the solution stated in
https://groups.google.com/forum/#!topic/repo-discuss/Q9WaMzzf5hs ?

Thanks & Regards,
Jhoola
