From: Muhammad Kazim <kazimalik@gmail.com>
Subject: Error "Unable to look up android.git.kernel.org (port 9418) (Name or
 service not known)"
Date: Mon, 22 Nov 2010 02:46:08 +0500
Message-ID: <AANLkTik-Fr=0PL+T3geL58qZOX8nt53PLfgVphj4GaYT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 21 22:46:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKHjk-0005Th-CE
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 22:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab0KUVqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 16:46:10 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60177 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838Ab0KUVqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 16:46:09 -0500
Received: by qwc9 with SMTP id 9so115635qwc.19
        for <git@vger.kernel.org>; Sun, 21 Nov 2010 13:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=be9udyUfwjQ/rzcg01ttgIOYGUXCXTP0BDGAXcZAjII=;
        b=WMhn2ddtM6vQXhOnV4zGcF6CLfou4Kh1vWvcbBHZ0+aIEnqZTJ8ZxjKdLsZGRNwMop
         2dtFlqub2GEokBxNkc6FScFJhmt753b9eam0V0ofS1H7ELqzW27Jycp2IPWWCzRR8+mF
         8A4ByOhMjOinMdO5rFgiu2/OvPmJ9acNumhD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=JMkqz/UyBOKqgvprM5CgYro1PAeTH2zBNOGGtePne56mjv3XMGBrVs+sARpAOe2146
         0ZSOaJHkZ6b2LCi69N6qMugTRuLZxFWMgmFeFyjx2nvht0X3OcaXuWT3JoJH8jbwVRTP
         7Rw4Izkh+Ur5Lrf01oXl13gbL2rJjRJd79d6s=
Received: by 10.229.181.74 with SMTP id bx10mr4395755qcb.163.1290375968375;
 Sun, 21 Nov 2010 13:46:08 -0800 (PST)
Received: by 10.220.169.209 with HTTP; Sun, 21 Nov 2010 13:46:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161871>

Dear All,
I was looking to get the Android source code in ubuntu 9.04. I entered
the following commands

-repo init -u git://android.git.kernel.org/platform/manifest.git
-repo sync

After 9% downloading was done an error came which was

"Unable to look up android.git.kernel.org	(port 9418) (Name or service
not known)"

I am using DSL connection and i am not behind any proxy server.
Kindly help me to solve this problem. I will really appreciate any of your help.


Regards
M.Kazim
