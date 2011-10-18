From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Compiling on Windows
Date: Tue, 18 Oct 2011 15:08:16 +1100
Message-ID: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 06:10:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG10P-0000wM-Dw
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 06:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397Ab1JREIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 00:08:38 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46085 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab1JREIh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 00:08:37 -0400
Received: by bkbzt19 with SMTP id zt19so291934bkb.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 21:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=qn5/4K8IKxZ2E0X8xBYUhJF1GLl6iwNmKmIcNm89zhc=;
        b=AR3w8VwUJ0cpokGJCdLo0LK62NMPDa/YHwFozkV7fgpWkv6m9ai9zsJQDqDsNGEZhU
         JaO7ndYK+FkXmolbYxJ9SdejH8KM9YbRZnvGXV1K5lPW6RRrznCRMWdRcLkYmw5UcfER
         wEnoPbWiJ0wWPIIeyUUEh8u1YNLaSzWzflhz8=
Received: by 10.223.57.139 with SMTP id c11mr1323309fah.24.1318910916132; Mon,
 17 Oct 2011 21:08:36 -0700 (PDT)
Received: by 10.152.13.100 with HTTP; Mon, 17 Oct 2011 21:08:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183849>

Hi list, I have been searching for details on what is required to
compile on Windows, but haven't found anything conclusive. Perhaps
there is something on the wiki, but unfortunately it is down at the
moment.

Can anyone point me in the right direction? I would like to be able to
compile and test topic branches, and perhaps even do some dev work on
my windows machine.

Regards,

Andrew Ardill
