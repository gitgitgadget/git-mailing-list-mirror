From: "Christian MICHON" <christian.michon@gmail.com>
Subject: how do I merge completely unrelated repositories ?
Date: Thu, 26 Jun 2008 11:39:37 +0200
Message-ID: <46d6db660806260239xc57ffaag6469967ae2257cb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 11:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBnyM-0004ri-HB
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 11:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317AbYFZJjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 05:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbYFZJjj
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 05:39:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:13278 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbYFZJji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 05:39:38 -0400
Received: by rv-out-0506.google.com with SMTP id k40so8636162rvb.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=WRvbIdBBCBHzkEoMSaIkgAhIz+kGetm+c4GQO+RJkfg=;
        b=X5lDG3EydZMW2Tt73JlCOYtWFdHhDgcvQLBmpbF96YQm721SNDRLGsz31JWjh9G7OD
         1bR3BdUuzLAK5Uaj++GVA2rVAcCZCja1NckyCpK/P2/QkJwuIjKzB8dA2Y4+ai+Cl+YO
         oVcXMAl5bxG0E31q3rWlwggFVcGA2iPPwG6Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ZZLdHoFCIwwhQCRPMbpVkthL5zPQkNAgzEoEnoGk2Gnoxluniz8B36nCkENSD+D6sZ
         F5AfJZeHxUfkTWslMjPsQtWrtPGoOmyoshxOHS44iJRvgSQHzX8jvk+Th//x/HPxw9VU
         rjnpNNKcUvbA9N7hTxfGd34SQxH0JPezkolVw=
Received: by 10.114.177.1 with SMTP id z1mr6933882wae.37.1214473177986;
        Thu, 26 Jun 2008 02:39:37 -0700 (PDT)
Received: by 10.115.16.17 with HTTP; Thu, 26 Jun 2008 02:39:37 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86423>

Hi,

I'd like to create a new empty repository and merge into it 2
completely unrelated remote repositories.

How would you do it, since merge will not merge if it cannot find a
common ancestor ?

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
