From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: how to list all files that will be comitted
Date: Wed, 25 Jun 2008 11:31:31 -0400
Message-ID: <644094BE-2835-41EF-B1B4-615B8A4BD509@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 17:32:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBWz6-0003Qm-0s
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 17:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbYFYPbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 11:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbYFYPbj
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 11:31:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:3642 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbYFYPbi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 11:31:38 -0400
Received: by rv-out-0506.google.com with SMTP id k40so8246398rvb.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=aLSSz13VuqqrbgMZ/biNtZVNT1jNCU8gtxXbc7Rby+E=;
        b=oKjlTOQ2O/UPfY1rNwJzQZ0lt+Yqaav9sHdxbBy6Avd0+/WHNtEqkS33DA1jYdlZjh
         wfxihlPdMC2KsDtCjD+a8OKzaTvLUbb9aMuB2GxuQjF1NaOKuOOhHZzmLFmrqk6JwUZM
         hWJRoiLi9vjMupJ9GPIjKaaHTFS7xTiJanQMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=iCHHVw2Uqxrs0mN8bpUpTQkWabKtDVb2DndpTY5dOoBPpeUBKXPjav6dHY2QlKW0WV
         /nw8Nq2NXV9pKgg0lnKT3r/t8JztydhaBtTvpip8G/ofMr3jwhiOW68byHtgEnWBoCBD
         g9fQAjC1HT13vHqP/+KiqCugQmmkGMDRYepLw=
Received: by 10.140.171.18 with SMTP id t18mr16453281rve.249.1214407896175;
        Wed, 25 Jun 2008 08:31:36 -0700 (PDT)
Received: from ?172.30.0.244? ( [80.67.64.10])
        by mx.google.com with ESMTPS id 74sm2115196wra.12.2008.06.25.08.31.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 08:31:35 -0700 (PDT)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86290>

I know ls-files is the tool I need but I haven't been able to figure  
out what combination of options will give me the files that have been  
added to the index.

-Kate
