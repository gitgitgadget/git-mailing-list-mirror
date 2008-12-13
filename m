From: "=?GB2312?B?wO7Wxw==?=" <lznuaa@gmail.com>
Subject: Announce: TortoiseGit 0.1 preview version
Date: Sat, 13 Dec 2008 16:33:22 +0800
Message-ID: <1976ea660812130033m2d54cc57tfe134fab0d687d71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 09:34:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBPxS-0004HZ-D7
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 09:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbYLMIdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 03:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754019AbYLMIdY
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 03:33:24 -0500
Received: from mail-gx0-f12.google.com ([209.85.217.12]:56350 "EHLO
	mail-gx0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874AbYLMIdY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 03:33:24 -0500
Received: by gxk5 with SMTP id 5so1259457gxk.13
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 00:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=fwdJYru2WPM6z4j//8nG1tkw/4rnkku04OlCZymJ7Z8=;
        b=tC93ITUdlvZptsuMgtH8FS+XdY/JWCxDqPZhhExLf9dPVwmU30CVdQ0gBiavop4+sl
         iHzfCd+0V8JgpAPposAxWenC18LUdIYQzuwdGCS96ntImheUu1AFNNteEV6QS7594uYh
         uoTVYDpnwiylxEw1syre8xvMbXZHyY/xJqZI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=rBN/2vrnKXy8+RfJ4iWiGbVoVrdOnkR/goJ7wpD4V1jhZzs8jjiIIY0QbK4/MWihlC
         Kg/MXsGNni+v4cjB4Ps/ltE9cdPcwScSlWLNNOzf9EymxbWtGg9VBd8GCWjGkSYa2Fb5
         j4+8ZogFGwN38u5ONQBTJunrAGHCVYIDPfqEU=
Received: by 10.150.192.4 with SMTP id p4mr6476226ybf.243.1229157202947;
        Sat, 13 Dec 2008 00:33:22 -0800 (PST)
Received: by 10.151.134.2 with HTTP; Sat, 13 Dec 2008 00:33:22 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102993>

TortoiseGit is porting from TortoiseSVN.  It is explore extension.
This version just finish a min set of TortoiseSVN porting

1.Context menu(subset of TortoiseSVN)
2.Icon Overlay(version controled\unversion controled at directory)
3.Unified DIFF
4.Use third part diff tools (such as kdiff3)

5.Commit change
6.Show Log
7.Create Repository

Project Home Page at:
http://code.google.com/p/tortoisegit/

Source code at
http://repo.or.cz/w/TortoiseGit.git

It need msysgit 1.6.0.2.
