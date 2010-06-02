From: John Tapsell <johnflux@gmail.com>
Subject: git ls-files ../
Date: Wed, 2 Jun 2010 20:34:59 +0900
Message-ID: <AANLkTile_3dP6OKTf89XEX8kySYcUyIGbBSRokkKTY4r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 13:35:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJmDz-00075b-8g
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 13:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723Ab0FBLfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 07:35:00 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:37844 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab0FBLe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 07:34:59 -0400
Received: by pzk15 with SMTP id 15so2148905pzk.15
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 04:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=1miG6uIFnbLu3EdUo2oQLROWq4BUXA+CyW1Aqwvk4W4=;
        b=GlMY4cgxG8jnK/9M2nPgPTIJ55h2SJB9+02Vl+pYrUItKkcxSwjN7XQFrAXZWb27Z3
         P+zWwK48L6Jqj2FKd7ybsVAT6o+2lKQRIu9wRetwPUSBz3C1SWLbcQuMwgOniMhT/ZCX
         LtyC7h55ffCY775cqgXUJRIBm5CXrsIx1iROI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=EanXxXaxDUxE6KMcnimRtz0TvcUnE7kFeDtpiSS+GTAVpwws6E6DZ7kf02VW0WoN2t
         rvn4TeGI/1drWruFwCdCduV52W5zdQ8FJLskVoHoSp8mGuXaV4sDFtWkAljfvphru0/K
         fEu8n3yVSVtGo0n/CoDWSrD2ANfnZb3FYHtpY=
Received: by 10.115.84.40 with SMTP id m40mr6793641wal.223.1275478499197; Wed, 
	02 Jun 2010 04:34:59 -0700 (PDT)
Received: by 10.115.79.12 with HTTP; Wed, 2 Jun 2010 04:34:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148247>

Why doesn't   git ls-files ../ work ? :)

I'm trying to find a way to list all files relative to my current position.

John
