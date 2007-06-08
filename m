From: Jakub Narebski <jnareb@gmail.com>
Subject: Spec file for StGIT (or equivalent)
Date: Fri, 8 Jun 2007 02:24:20 +0200
Message-ID: <200706080224.20493.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 02:19:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwSC1-0006u8-TV
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 02:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbXFHAS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 20:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756794AbXFHAS5
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 20:18:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:62239 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbXFHAS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 20:18:56 -0400
Received: by ug-out-1314.google.com with SMTP id j3so808549ugf
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 17:18:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PDKfSV/wm3q4qTfmYk4p9BRvAwNGporz14NZLkqMfzitGthIK8VgvnkUh75Io/NfAKvFKe/L3c6tyj8MpnFLZovGmBLh0QDDg0z+75lyj5PcjmENbYm6JmcZyo/SffP3kQksgKtlQKUDO1eKO+IEqP9yxf4riig7rrbSezomyqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Qvgantt27IOKT4F7tyuQHwJX8pyJKZAXhklb9Dzp0AUa8W9ClJ5qVf7PxMXPPp2EvdTY/jhkS1ABS44jmSsjtIk90l+f45Bm6sbKZPPvXKaOoZXKcXWEGWjh6UKDzVbGjQSuBkosXPg2HmA+1r2eUCwZmknAXCwJOWVZHznLZ8Q=
Received: by 10.82.123.16 with SMTP id v16mr4274766buc.1181261935053;
        Thu, 07 Jun 2007 17:18:55 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id d23sm3127350nfh.2007.06.07.17.18.53
        (version=SSLv3 cipher=OTHER);
        Thu, 07 Jun 2007 17:18:54 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49418>

I can see that stgit repository contains some helper files to build deb 
package. How to build rpm package from current version of stgit? Is 
here main version planned to be released soon?

-- 
Jakub Narebski
Poland
