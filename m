From: "Kevin Yu" <yujie052@gmail.com>
Subject: What's the status of MinGW port.
Date: Mon, 8 Sep 2008 12:34:06 +0800
Message-ID: <42b562540809072134xed61f0as6f1201a641ec973c@mail.gmail.com>
References: <42b562540809072128o62854572y1eb8d2e69e7193f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 06:35:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcYT6-0004dC-OB
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 06:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbYIHEeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 00:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbYIHEeK
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 00:34:10 -0400
Received: from ti-out-0910.google.com ([209.85.142.186]:37646 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbYIHEeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 00:34:08 -0400
Received: by ti-out-0910.google.com with SMTP id b6so758866tic.23
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 21:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=K/iDO6Xg10JXqyrSPBNn7eL40Z/PgqciQL3woOLvbto=;
        b=JcS2ae+OavxF1hJDLi9qhCAIbV8SPefQudQCw/XLhVSHS3HU37/7aVnaLC21njAUPl
         e9Mz935YYJ0bLx6oq8QBtL84MWDLzt/fvd11CRtzk+bVKLIFOjyRfRCnd7dB3dnvsSVw
         2OHMIkwtWxlLBQpY1YAfz6lFtnyjrr2KS4baI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GZkpBeYNRVvFnanuZhMI2X+gjexnbDkH+cDWoSjTmTt03k112sIBsKocBhtAsgFwUK
         u8Jzup9+YWhBh1Cy92yudfP8BPM3nQaVavSO/GMg9hTLm98MpPUYmAQbqJVxMI52Nkn7
         ZW0V453KgEoAUxa1CHDjgpQ90T3Q9GgmGghVE=
Received: by 10.110.70.17 with SMTP id s17mr6216452tia.56.1220848446330;
        Sun, 07 Sep 2008 21:34:06 -0700 (PDT)
Received: by 10.110.28.7 with HTTP; Sun, 7 Sep 2008 21:34:06 -0700 (PDT)
In-Reply-To: <42b562540809072128o62854572y1eb8d2e69e7193f1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95215>

Hi,
      GIT is a great tool, but I'm running Windows XP.
      It seems like msysgit hasn't been updated for a long time,
neither has the mingw.git branch.
      Is there any plan to create a native version of GIT on MS Windows?

      Anyway GIT is great. :).


Best wishes.






                                                 Kevin
