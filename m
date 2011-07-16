From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Google Code supports Git
Date: Sat, 16 Jul 2011 17:24:50 +0700
Message-ID: <CACsJy8BMK4UqVVNnhs6riVSS-OKcFKT9=XScrAw5nK2FH_u92A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 16 12:31:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi29L-0002bf-Cl
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 12:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab1GPKZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 06:25:22 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:44903 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab1GPKZV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 06:25:21 -0400
Received: by fxd18 with SMTP id 18so3971246fxd.11
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 03:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=H5s6LWM8KyzRmfTiHwJ0UKO68PdEWrxCyA0fG5Fht0g=;
        b=U0F/xaEk8v+MMdl+Y3qJrcff3pqyhm2B4LmWKpsqFtH71+q2Bb/9gRHuAaHijq1doc
         jzD6AwK+F8JAspqrHEVMjC+2vVxve2hq8nCwcmv+dBBeer5u0iz/BZ+pRtenXzAWojal
         tVhTiNFExE0zHA+2rKZ/sIxVwQM0jpzSFId4k=
Received: by 10.204.49.6 with SMTP id t6mr53176bkf.135.1310811920381; Sat, 16
 Jul 2011 03:25:20 -0700 (PDT)
Received: by 10.204.123.199 with HTTP; Sat, 16 Jul 2011 03:24:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177252>

Just out of curiousity and because I happen to know we have Googlers
here. If it's not confidential, are there any changes in git to make
it work with Google Code? I am particularly interested in whether
Google modifies git to use bigtable (or cassandra, I remember Shawn
had a prototype).
-- 
Duy
