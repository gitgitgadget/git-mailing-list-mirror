From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Man pages lack of exit status information
Date: Thu, 17 Apr 2008 09:45:09 +0200
Message-ID: <38b2ab8a0804170045xa542274pa9f1e434f428b1cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 09:46:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmOov-0000LI-G8
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 09:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbYDQHpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 03:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754050AbYDQHpL
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 03:45:11 -0400
Received: from rv-out-0708.google.com ([209.85.198.243]:3841 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753830AbYDQHpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 03:45:09 -0400
Received: by rv-out-0506.google.com with SMTP id k29so1335023rvb.1
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=mjDZhrhjzdusd+MfcR5qu9dxHiOP52tBoDeHT9g4kXU=;
        b=EdnlRLINZrX284pUl+96eEWXOvySnSdKbqwyOPJt/wuV4T9R1unM7J+hplN+xJIw0VUmvAx7/4+QTvbqYmh5UJK7T1n5+DNgVjD5nvxyrn9sV5QMEZSCDFKWIYxy1iLu80ZvY7iBWTvyfzhIM6vuVFgd4F2pfjbAeOVg7grJZXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=vGNM8khGRuEIW7dwt4dD76GRd5Oo9p757X10EKpsizuhrF61vTbQYA/RU3pgzxtQAEfDwgzko8StYNG44EgdcBQnvSqWSvBWX16ydRraHNbNWZg2kunWoVbtrlgcj3wZLNh6xD370z0bImlBmh4XC1+xszj9pZX/N02X8g/X82U=
Received: by 10.141.27.16 with SMTP id e16mr559951rvj.141.1208418309374;
        Thu, 17 Apr 2008 00:45:09 -0700 (PDT)
Received: by 10.140.135.21 with HTTP; Thu, 17 Apr 2008 00:45:09 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79773>

Hello,

I checked on a couple of git commands' man pages and I couldn't find
the exit status of these commands.

For example: git-status, git-diff man pages don't tell anything.

Am I missing something ?

Thanks
-- 
Francis
