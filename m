From: joe higton <draxil@gmail.com>
Subject: Git merge selective files
Date: Tue, 9 Jun 2009 10:53:41 +0100
Message-ID: <34b359190906090253v653ecc71q6684f4ebff2be59d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 11:53:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDy1f-0007ZB-IW
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 11:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144AbZFIJxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 05:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbZFIJxl
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 05:53:41 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:52681 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168AbZFIJxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 05:53:41 -0400
Received: by ewy6 with SMTP id 6so5013609ewy.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 02:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=9NYyquZdxN1oKEiNh6hjJ1YvfbUY8Xsmp6v3oYxfYX0=;
        b=GWf6pGvUpl9xbOlJ3Z6yZl5xv+KlmlyR5l5wRHwp9VYeXkdXUy+WFCyPBra0RGd7vS
         R9nJdzXWPVFAc7FfbPt1Nawi3+6GLLJ5Lw+kvv82qr5Q80IA4HUvHArA+lvCzIu6MrQA
         JKjadnglT3YA19oPU+d2ceN3m69NohTO9GAJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=o4ViSKMoY7nINoGnflh0wg7M/Aid9WbdnbyoeeAoSLcnqEwrT2wSph/6oHzy2X9ryi
         iWrQ4LtwNYCrO7Hi5xf3h1mxq7A+e+Qd5soCPabFYhnhfGrjX9nJrQme43H36Rjp36EO
         ipM8eawSFIcqTj+L4RHrYvEyaFMC4NZX74DmI=
Received: by 10.216.29.210 with SMTP id i60mr2736187wea.84.1244541221948; Tue, 
	09 Jun 2009 02:53:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121162>

Hi,
     I want to merge changes from a branch but only to one file, I
don't want to pick up the changes from other files. I've scoured
google and the docs a bit but I can't find anything useful. Is this
possible?

Ta,
  Joe.

-- 
Gmail is watching you!!!!!!

Please don't publish this email address or use it for anything SPAM
risky. My more public email address is joe@draxil.uklinux.net
