From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: should Documentation/howto/setup-git-server-over-http.txt be marked obsolete?
Date: Fri, 22 Oct 2010 09:18:32 +0530
Message-ID: <AANLkTimJe9vEUwWM482NLmfHGYjnsKD5RAryQO=Zyqjj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 22 05:48:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P98cZ-0002aV-31
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 05:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab0JVDsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 23:48:33 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61183 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab0JVDsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 23:48:32 -0400
Received: by ywk9 with SMTP id 9so314353ywk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 20:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=x9UDJmeK3L69nXjY63mYLz6F+ii/JznLCeSFrPNnH3k=;
        b=aXvzO/GGlqTLFG/5iLK9JdqEFtZXJJvkZ6KU7vmoMTtWeqIyl8tNsKp5sjqZIs6uzI
         zulQ5Gevnk5K5mhZihjWJL/DFVObUyEt7iUDq78XzI0CuoGgCV+Efu2wwY8KK7Ffhuzk
         SuqccP8NurDQR5k8N/+a318V2hgCHgo+PPdKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=uvqFfGWO3R9C5jDYowE77OlDyD2JJIsnU1N2NWWfHiIHySwfnWMUll1IXJOTN8GMVp
         j2QqZN2AvApbsUsUBMm2GlO7Y4r9TnQtRxKLeSGL7pK+i8rGxA1SD7RIqnmoSYjq44J6
         b2z0LnqR8qfWwvKPW8OnQs6g8B0xiFOM7ha1w=
Received: by 10.90.31.4 with SMTP id e4mr1935310age.113.1287719312201; Thu, 21
 Oct 2010 20:48:32 -0700 (PDT)
Received: by 10.90.83.17 with HTTP; Thu, 21 Oct 2010 20:48:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159633>

Subject line says it all... While working with people trying to use
gitolite's new support for the "smart HTTP" mode, I find sometimes
they get side-tracked by this document.

Is there any text we could add to it to say "ok guys this is from
2006, a lot has happened in git since those days..." etc?

thanks,

-- 
Sitaram
