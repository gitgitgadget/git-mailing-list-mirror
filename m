From: Ping Yin <pkufranky@gmail.com>
Subject: How to exclude some files when using git-archive?
Date: Fri, 16 Jan 2009 10:40:11 +0800
Message-ID: <46dff0320901151840l18257501x62a3fa1fe9701dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 03:41:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNeeR-000794-S6
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 03:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761402AbZAPCkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 21:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759740AbZAPCkO
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 21:40:14 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:23376 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759284AbZAPCkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 21:40:13 -0500
Received: by wa-out-1112.google.com with SMTP id v27so756429wah.21
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 18:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=gr2m833EgRwVlbBj25rL7qfnS55krk+v+LmOZb5EUuI=;
        b=MIM4WNyRg0RNyYn361KWHcttXj1J2pppe23hVXosXi5ntNCKLvcMZPp0rtW0LrSWBN
         ZFMAG4oDXLStWD9r+rr3QZFnff9JWHNDRIP2+ZrkctIODw2rHTErWIqZ0WMLFHDiP0qU
         4bLK33XGkEtnJ5Wa1v0hjuMp73Xnm8SzcHLAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=OdvlS1HZuZNHeyPNkHAR3x3GkGI4K1K1W2qQGIFDTG1ePbw16W3v24KPevs4FE7eh6
         un12HD52Vatz74VF0mgzrBVhOn4ViB3hhS1vxEhiiNKfrjyDjAW036ZtPas/9QR4pYXK
         i5QrbGFtMLv5d0qwQNVNZ+TcgsJUcII+k/uLo=
Received: by 10.114.124.1 with SMTP id w1mr1389715wac.132.1232073611153; Thu, 
	15 Jan 2009 18:40:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105912>

I want to exclude .gitignore from the archive, but hasn't find a easy way

Ping Yin
