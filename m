From: agnes retnaningsih <agnes.monest@gmail.com>
Subject: ssh admin git accidentally deleted
Date: Tue, 7 Jul 2015 20:30:59 +0700
Message-ID: <CAF1FN5CDnUYxjChO2PZFrDnPRUiuqXhko=iDo=tuqwvJJdUg5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 15:31:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCSxl-000146-UV
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 15:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602AbbGGNbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 09:31:00 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36592 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbbGGNbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 09:31:00 -0400
Received: by obdbs4 with SMTP id bs4so128605660obd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ETpoE4Ts8spPH4m5oYZtNZj8D+k0HpWHV0H2wTak5ZU=;
        b=AO+7kqHYv0o1NSvMk8VPjl85e6XujsWQ6BwZxfVdSncPV44cLdCbl6PxlIJ3joU9ve
         qJI3iZDCeIbx+KyjV4hjCt8t5HQCtZEMytQWpGi6D7DngpTL/UEU/FrMLUk3Fw8fipMJ
         7qIizghZ1+EKM0aI3CvtCo7gxK3LXYdBxqBMBu6wU3K5B0d44Hsc07fuOZCYvQt51DPg
         mAS+MGNPO70AYATnF3gOSBpw+8nQXdVZFoZULC6zzD6oH8WU2W3NC8TeEBErkPvFVV8Q
         DLOZ+/w/kuVSjPLt/q8CyM/B3un3Dgy2MAKblpFBwh5nudHn4qOqk67Go0RQHrXvY2dk
         CXig==
X-Received: by 10.202.1.67 with SMTP id 64mr2669567oib.6.1436275859651; Tue,
 07 Jul 2015 06:30:59 -0700 (PDT)
Received: by 10.202.183.212 with HTTP; Tue, 7 Jul 2015 06:30:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273501>

Dear git , I accidentally delete ssh admin git, unfortunately there
just one admin so I can't make a change in the config and push to the
repository. If there's a way undo the change or make an existing user
become an admin or is there any super admin command?

I use git version 1.7.5.4

Thanks.
Best Regard,


Agnes
