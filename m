From: Trans <transfire@gmail.com>
Subject: Empty Directories
Date: Fri, 15 Aug 2008 17:20:01 -0400
Message-ID: <4b6f054f0808151420t59001ba3k2fecb19a73e5addb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 23:21:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU6jL-0008MU-Ei
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 23:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbYHOVUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 17:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752941AbYHOVUE
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 17:20:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:17900 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbYHOVUC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 17:20:02 -0400
Received: by wa-out-1112.google.com with SMTP id j37so625646waf.23
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=K/7CADMyL7DEU+E7RP6AhG50nkSs8tdOnMuAPF2pEys=;
        b=AlnXU6O4tvcQKjITw60yp1QMqgH5gXoXGi/+Wq1Rm3K+Y9ArzMtP62stBLdkCstbT5
         TIprYPdfQFPLtL/2hEVbqhgUi7lEBYqVPazJdjLY+Nz+eJ4VU64pF3K7Q3aFlj6qlVVK
         GTRV+9uETo3RAjPSm7nvUT8bgogAqFgTkWRy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=V5XzW0ymukQIoGMsoDzjjavsDdoVx0l3htac9s/Q7BGqhvjrIGGLY2fh84oS5i6Y9M
         10oG3tvl1awPuoXjMD2Uarl/Vxu1RfQ+FrP066lGXeflq8N8SeoctaeXiT/xckw/XYE5
         WxYdYwfpEbnDAkhDmCv6PfOw565qiFzHAD330=
Received: by 10.114.195.19 with SMTP id s19mr3222261waf.110.1218835201562;
        Fri, 15 Aug 2008 14:20:01 -0700 (PDT)
Received: by 10.114.56.19 with HTTP; Fri, 15 Aug 2008 14:20:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92519>

New to git...

Is it true there is no way to track empty directories?

Thanks,
T.
