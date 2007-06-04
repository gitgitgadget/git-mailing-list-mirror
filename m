From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: git submodule init
Date: Mon, 4 Jun 2007 10:17:52 +0530
Message-ID: <cc723f590706032147i2f10ea59v923c8ad3a0e8eff5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 06:48:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv4U5-0007Jt-Oz
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 06:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbXFDEry (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 00:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbXFDEry
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 00:47:54 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:22714 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbXFDErx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 00:47:53 -0400
Received: by nz-out-0506.google.com with SMTP id n1so897457nzf
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 21:47:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mYrb81Ct1DCKkvO//hTU4ewGakW8UaAGsJjOA8mNhlsMUQ5SsYfXJ5XfR7CKkowjpFBWvXI/Le3gbx7E3NBEbDRC/Jm8Fqfs1Xnax7XP4P9Ket4lGYaVRaYTeiARgq30FRvoXJnkYI0II/te4Lgzk9SqECaa+6/HC/Xam3E3Qc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=L27AIMEuOAV7PchF5PxCUIY/wH4aHoE1jeFqks3ObIEQcjov+M7zhX+1sKVxkovNKfW8iXEvt9dbVblcNXB3ZY8PibjqfylIxq7eIpQSERW5q62kdJKPSP42w0h4Kc6LvKmauAWDSTwodry4kv48ORYwWIm8lE9g88adIwRYS8k=
Received: by 10.115.46.9 with SMTP id y9mr4375829waj.1180932472798;
        Sun, 03 Jun 2007 21:47:52 -0700 (PDT)
Received: by 10.114.240.11 with HTTP; Sun, 3 Jun 2007 21:47:52 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49060>

Hi,

I guess git submodule init should support different options for
cloning such as -l -s --reference etc.


-aneesh
