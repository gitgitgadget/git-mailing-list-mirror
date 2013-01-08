From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: submodule name and path
Date: Wed, 9 Jan 2013 02:17:42 +0800
Message-ID: <CAHtLG6TuHtk2P3w70-vUVGkdrv7R3VWyMzkGA4sr=G8xiSuEjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 19:18:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsdkc-0008DE-6A
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 19:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757022Ab3AHSRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 13:17:44 -0500
Received: from mail-vb0-f43.google.com ([209.85.212.43]:44414 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018Ab3AHSRn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 13:17:43 -0500
Received: by mail-vb0-f43.google.com with SMTP id fs19so697686vbb.16
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 10:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Up0zotcfTPE2XjXQqP/upfAgmYong4aXmd2ikOXSOXs=;
        b=oSvq6cX1SGmkglWxkpeeGJjmM6AmOrQkTtx47iYmbkiQPA/ruUu/1pkpT7CWEPF1ev
         5365HrYAFaJ7jD/8t1a3EzbXipqZ6057/3UWyVCeZokKZPqci/6T6nD+HtHb4cMcJLbj
         K87nbrN+mJ2BoyJW6g6D3PRH22QIGsFqUN1qpjd9nFAsAH6N80224qLtO+bZd6pkUDow
         pUPf9s//Ez9r1+csk602cJVZTWlUDOi64/VsJj1EykXFMDwJvJY5XKcKpNChhn8C8VKQ
         uqe88sj50nA+lSbbm67C66TotVPwwjzRjaNGvwvx6nUXZy23c0JwsjI9r1l2vDuZscQE
         17GA==
Received: by 10.52.92.131 with SMTP id cm3mr76337591vdb.110.1357669062737;
 Tue, 08 Jan 2013 10:17:42 -0800 (PST)
Received: by 10.221.6.201 with HTTP; Tue, 8 Jan 2013 10:17:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212989>

Hi,

In doc, "submodule name" is not clearly mentioned?
What is the purpose of "submodule name"?
Must be same as "submodule path"?
"submodule path" can be repeated, while "submodule name" unique?
