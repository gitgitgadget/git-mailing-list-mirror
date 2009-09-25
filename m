From: Michael Gaffney <mr.gaffo@gmail.com>
Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
Date: Fri, 25 Sep 2009 10:48:16 -0500
Message-ID: <4ABCE640.6060102@gmail.com>
References: <891180.68852.qm@web27805.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Douglas Campos <douglas@theros.info>,
	Shawn Spearce <spearce@spearce.org>, git@vger.kernel.org
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Fri Sep 25 17:48:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrD20-0005NW-GO
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 17:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbZIYPsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 11:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbZIYPsP
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 11:48:15 -0400
Received: from mail-qy0-f174.google.com ([209.85.221.174]:61631 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbZIYPsO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 11:48:14 -0400
Received: by qyk4 with SMTP id 4so2087301qyk.33
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=WFELC6YjrkXXBZ6toNhfBSEj2BNRk4/j15Oru3Rbu2I=;
        b=QAP3PhF8cO9No5+iPJMiBFePJwfwjpbfwFD4PzhT5CIkwHWIp1I58UhpqRY8lDBxrk
         alkodxybu/hhTSgZzQZdHUk4JC6yOqBDxfQQu8y8ilKy+JKMqjk5VqMCQ2ahxPVOn6Qe
         n3qqG+O+dPeq/QHCE36RWhirNJPne28nEFw1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=uKNGgF/fCIZ0BK6CgryKNLE7Syt74pi1yCiV/O6av1GSsOl7WLsDVLxUNZwpQKY1Sh
         w2ePI1UG4R32wf2hW/9umB5klplT1grdCdij1uadRGlQBX3QzHry8Iwj6QAdLxFXG/BT
         3q1EBe4mKK6L2+BP0VAnOoyoZdavnLHpk8ZkY=
Received: by 10.224.3.212 with SMTP id 20mr343418qao.239.1253893697989;
        Fri, 25 Sep 2009 08:48:17 -0700 (PDT)
Received: from ?192.168.11.102? (nat.asynchrony.com [66.236.120.131])
        by mx.google.com with ESMTPS id 26sm664078qwa.9.2009.09.25.08.48.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Sep 2009 08:48:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <891180.68852.qm@web27805.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129094>

My only real item is that I'd like to have the .* eclipse projects added 
to gitignore so I'm not having to constantly stash mine off to the side 
if I make changes.

-Mike
