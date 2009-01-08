From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: Can I prevent someone clone my git repository?
Date: Thu, 8 Jan 2009 15:03:19 +0800
Message-ID: <856bfe0e0901072303i4fcd3bf6u99790ab9f4170937@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 08:04:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKowe-000102-RA
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 08:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbZAHHDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 02:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbZAHHDV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 02:03:21 -0500
Received: from mail-gx0-f13.google.com ([209.85.217.13]:63808 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbZAHHDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 02:03:20 -0500
Received: by gxk6 with SMTP id 6so6976172gxk.13
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 23:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Jkh32SJ4ctsTv3yguGW8duZtWiRYvB1134tLkU9dI18=;
        b=nTzFbyWVjkgobCDs7t4k9jHMlIksA/0i2SRrjmIkbLmTcctSemmm42zgTC8XLCqcyX
         A4w5Ebjg8MzZQkVeemqyMsEA6XKfQ1A+61M5tPFcPL2ebAsoinrIF13qc/NJ1AmAozhC
         +p4C58/a2EtzIl9NcXIBpJjC5aHnxvXiieLKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=XDwvqlzwNb3+cBvCJmUodqEw1kfuF3/vKNUCzjimpWm/CUxotKw7DzdpUXRwgeDW0B
         Ef2xNw1oy5FZI7MPRgWYHytL/CneiqBCFjE1VrcuuPdlyrkiDQczVvCPnjnexl0JuBgo
         F9TTHhElJz09rX0dlQ8C5dsIjCUITXBfH28UE=
Received: by 10.151.112.4 with SMTP id p4mr1432919ybm.82.1231398199122;
        Wed, 07 Jan 2009 23:03:19 -0800 (PST)
Received: by 10.150.204.13 with HTTP; Wed, 7 Jan 2009 23:03:19 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104893>

All,

I want some person can clone my git repository, others can't clone my
git repository. Is it realizable ? How to do it?

Thanks,
Emily
