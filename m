From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [announce] gitpod -- local caching server for git
Date: Sat, 26 Nov 2011 13:56:37 +0530
Message-ID: <CAMK1S_ipY=z6afpOqqY=GDRf_tSzQDUZaHEYL688d=oQU0OE-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 26 09:26:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUDb1-0002Ay-TH
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 09:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab1KZI0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 03:26:40 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39455 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab1KZI0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 03:26:38 -0500
Received: by yenl6 with SMTP id l6so1677995yen.19
        for <git@vger.kernel.org>; Sat, 26 Nov 2011 00:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=yXHr5raawCknqT1vRAa4+foowkYmxzSHw6VRAAb6ebM=;
        b=XCO7kQKMautNJeo3rojG63V3Z+avWeVsc/GqHA0tT7IUz3u3Ct7FAXoTerbEO0CYvi
         OnR56tIf3RT3u82/dFChoYz08aVnr+Q5o8+HvGCA5Wz0cxiGxrr9MFfE0yaKmB8Esh3u
         mztCtz3J50ObD11fgofCUz/qJ06/nA8ZeYGYU=
Received: by 10.182.147.4 with SMTP id tg4mr10919979obb.60.1322295998018; Sat,
 26 Nov 2011 00:26:38 -0800 (PST)
Received: by 10.182.6.41 with HTTP; Sat, 26 Nov 2011 00:26:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185949>

Hi all,

If you have a bandwidth constrained site with multiple local users all
cloning/fetching the same set of large repos over a slow WAN link,
this may be useful.  It can be set up to be accessed via git://,
ssh://, or both.

You can get it from https://github.com/sitaramc/gitpod

-- 
Sitaram
