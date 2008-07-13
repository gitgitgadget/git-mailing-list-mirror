From: "Rob Sanheim" <rsanheim@gmail.com>
Subject: Q: how to remove or move submodules?
Date: Sun, 13 Jul 2008 02:38:51 -0400
Message-ID: <fc113d400807122338o637cc159n5e19fea5a15dc866@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 08:39:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHvFQ-0000W9-JO
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 08:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbYGMGix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 02:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbYGMGiw
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 02:38:52 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:43673 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYGMGiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 02:38:52 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5059794rvb.1
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 23:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=F/V9oyRSOSsyZfhXCS9vgJh97gld8zeGmsQeZ1PAxCM=;
        b=FAGeqokdvUM4Mzs7/rjpSs/XuNBktzLDZJb5m6htHB/YPS7SYsuWDSmxgXG6CCMgzG
         ZBY/NSPvnZnEEg0IXdWJ/oY3ZAya2tQgE8MnMcZ0KEvXD27VqbtENvw5DDjf01grzbMw
         L01cC1XpzSNWatmTntUxsE7ZIA9JICKYyH3v4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=gLkbOznxL2F7dOnFBtzXgZrnzqh8nSJOtRyRA9aXtW6xnZaHwqPV7KTqed8rtPOle/
         AdmT+7xY36j/vYJkKsP5zF0EYIK6zk4dhHKeaZW0MHQWDgRdcta2jIpjczomM61OhcTk
         ZTYKo3Om0KSQfIalmYCYxI3D4yAEHZzpwS1C4=
Received: by 10.115.19.16 with SMTP id w16mr16196739wai.102.1215931131677;
        Sat, 12 Jul 2008 23:38:51 -0700 (PDT)
Received: by 10.115.79.6 with HTTP; Sat, 12 Jul 2008 23:38:51 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88290>

Hello

I don't see any info on what the 'right' way is to delete or move
submodules around in any of the docs.  Normally I end up just hacking
my way through it and hand modifying the .gitmodules file, but this
seems wrong.  Is there a recommended way?

thanks,
Rob
