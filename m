From: "Donuvi Tanoga" <donuvitanoga@gmail.com>
Subject: fatal: Entry 'xxx' not uptodate. Cannot merge.
Date: Mon, 11 Feb 2008 08:48:42 +0200
Message-ID: <30929dfe0802102248p1f1cca44q4cec26a3237a3f20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 07:49:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOSTo-0004oe-He
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 07:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbYBKGsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 01:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbYBKGsn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 01:48:43 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:43021 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYBKGsn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 01:48:43 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1984677wah.23
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 22:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ZEdcRwg/4XgCsOtcQo9z4/Xj5NVqOD3dl/cf5KUI6Cc=;
        b=wuHl1f2agcyTNhXbNsgTjS/vevfZxSyhcsYnAOS/eTELl4KU2B6fINkFW7rPFPzTDr2MVbqZXCHU60wpLZ4ByHWoYS9nG1YP0t2fzhQzUE8PcsSrcwquCl2bDW8RV9sv//7HhIz3OZBRcgs4OO6QevFUkueH0Rzb5F42Qt6cuzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YnSk+PzwvHAqcsWNbK5NyWr7RonF+VPSxOSiXnHO/u7dMwsSYlhn5oXtQeELByXFJH2B9d8uwSywac2xkCLZuMT8kOdjiHAQ1ZDOulOGFwIb8izbKKscmviFfpJyFDXjDnOGjDjYcJTQ5jGx50j3+/oinYYyrnHGinOhhYVpRI4=
Received: by 10.114.130.1 with SMTP id c1mr6464977wad.52.1202712522345;
        Sun, 10 Feb 2008 22:48:42 -0800 (PST)
Received: by 10.114.102.16 with HTTP; Sun, 10 Feb 2008 22:48:42 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73472>

Hi Everyone,

I have a problem I don't know how to solve.

When I do git pull (on linus' tree), I get the following:

Updating 9b73e76..19af355
fs/binfmt_elf.c: needs update
fatal: Entry 'fs/binfmt_elf.c' not uptodate. Cannot merge.

This is 100% my fault, and not a bug (I probably
accidentally changed it or something).

Can you please help me to fix it ?

Thank you all
Donuvi
