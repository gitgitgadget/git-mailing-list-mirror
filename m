From: Eugene Sajine <euguess@gmail.com>
Subject: [RFF] git submodule rm <submodule>
Date: Tue, 23 Feb 2010 18:19:46 -0500
Message-ID: <76c5b8581002231519k3e0a3289x71f7172e72ddcfe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 00:20:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk42x-00040U-58
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab0BWXUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 18:20:00 -0500
Received: from mail-iw0-f177.google.com ([209.85.223.177]:63194 "EHLO
	mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab0BWXT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:19:59 -0500
Received: by iwn7 with SMTP id 7so3621403iwn.4
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 15:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=SoYeaNOC5iZD37lGf7jlFGirMor/W1CymY/VEBUofSM=;
        b=Nh1Xud2SMsrwj5O9SgNmqQXShe58hfo0wZM04cy4yReM2kXPtpxw72EDVISXkeO9xA
         W/iyZmb6/+S/9fWLlxuQzQFdjpzkhlngJms0BR9jv6oxH0t6+0rW0kqr2oI6lGI853mz
         Sx1C2BsqqEw+f0vS25xTMM3HZWcFieynwGjHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=CUYjn1tWQ8egatwe3k16poiiSQ4Zk7hK0vdBtj3eWwo2XIONpzByadTFZZEn1h0L8B
         YnfjIaVtnu5xqG0HeC3kB20RBPOqZvpeH6/HvVl3a6oF9zv00+w7GCO7Mlg+bsoxhGfI
         HDzi7uRKh7ZavD3QRLRoj8vrzLTNaBLyHTOgI=
Received: by 10.231.183.133 with SMTP id cg5mr900045ibb.12.1266967186336; Tue, 
	23 Feb 2010 15:19:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140866>

Hi,

It's probably not a first time this question appears, but Is there any
plans to add the command to remove the submodule or what are the
reasons (if any) not to do so? Or am I missing something in docs?


Thanks,
Eugene
