From: Jon Smirl <jonsmirl@gmail.com>
Subject: jgit and ignore
Date: Sat, 28 Feb 2009 11:31:28 -0500
Message-ID: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 28 17:33:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdS7X-00025b-Hb
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 17:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbZB1Qbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 11:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbZB1Qbb
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 11:31:31 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:7144 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbZB1Qbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 11:31:31 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1143317ywh.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 08:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=F22SWsHCfmjt2Jksh7cOLFQdadcnGAErUlVqcp7KUjg=;
        b=t+SF6o8ZQRt4chBLAONtdGn1IOxrdyGUoVW6aazT42qsOMtJEayMwslmt7HIJ8ELqx
         0zQPdmtZscY2+SszsFpX6FNYsR1VXr7I6/erk5nUakwkHXvNORfmu50qeCaNtm8h0S2q
         xhcyXfEmzvdoXvMnfNR5pubmk0GTjsMOQvrt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=kSxq5Xe9I5ABG8T4bubkYBpITiJZd5SSxlMbzx5+Sw5D7zWqi2EjC32D7MNnWAJ7cw
         wUg4oXb72UWHWmUsiVVzX7i6eTG+qVOCF7bUcEe9UuKH66UfSEYR0Kfw3+JB105rXtVr
         y7u0gNwf8iXS05vRthPas7R6V9NnbhGfI9UWk=
Received: by 10.220.91.205 with SMTP id o13mr1302150vcm.92.1235838688112; Sat, 
	28 Feb 2009 08:31:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111773>

I'm using jgit in eclipse. Works great for me.

I have a couple of generated files in my working directory. There
doesn't seem to be any UI for ignoring them. Is it there and I just
can't find it?

-- 
Jon Smirl
jonsmirl@gmail.com
