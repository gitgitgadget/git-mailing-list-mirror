From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: incomplete footers added by list server?
Date: Tue, 23 Jun 2015 11:43:42 +0200
Message-ID: <1435052622.26582.3.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 11:43:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7KkB-00042o-N8
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 11:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbbFWJns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 05:43:48 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33888 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbFWJnq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 05:43:46 -0400
Received: by wicnd19 with SMTP id nd19so100335914wic.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 02:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:content-type
         :mime-version:content-transfer-encoding;
        bh=r29kFHc0JU63mbeGjD/TYxZPBg69TgT2nxybErvGQ8A=;
        b=RV5r1au4ABwsR99ge/gAmCTWY4Et/FUD7Ybv5gaX80erlGks5D6NxfCs/gLGIHUxJY
         cD+CGD6BB1CUDGBed04vps941M3hahIqHmPu9RF+hz2Xth+fGtzeDdZc4o66eItllWTx
         jpBHUOkia7DlMDzrJVB/1G5gIwmAecwsJ0rNyyiYAGWqAYxbVzKNWn6Z5FojthM4dRca
         iHZhcheDYF9OI3Y0BzXXPQmAh+E9sjJVUp0jUgWHWB0mB7LWFu9RR4ii5bw/bg/EDyo+
         ervCaTYY8TmOTK1zzMO+YRhWyXvkjewm7crvPWldY2opcz2VInK1peF0QulX4FCyGLbm
         NNmg==
X-Gm-Message-State: ALoCoQlNaP5wmqBCXY//LvaFhUM7dURo/rAk9H8atKhuNf0syk+rhZkhVGOmD6BzImddd13CWGXO
X-Received: by 10.194.95.132 with SMTP id dk4mr60635845wjb.88.1435052624666;
        Tue, 23 Jun 2015 02:43:44 -0700 (PDT)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id j7sm34720528wjz.11.2015.06.23.02.43.43
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 02:43:43 -0700 (PDT)
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272443>

Since last friday between 10:39 and 10:50 UTC, mails to git@vger
suddenly get an incomplete footer added.

Instead of the normal footer:

To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


Only the first line is now added, actually making it fairly useless :)

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
