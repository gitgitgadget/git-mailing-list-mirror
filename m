From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: cvsimport and mozilla
Date: Wed, 14 Jun 2006 21:14:22 -0400
Message-ID: <9e4733910606141814l3fafaab3o1e4a9f66712eb0a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 15 03:14:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqgRH-0003dr-C4
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 03:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWFOBOX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 21:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWFOBOX
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 21:14:23 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:51024 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750826AbWFOBOX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 21:14:23 -0400
Received: by nz-out-0102.google.com with SMTP id s18so394457nze
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 18:14:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iw76gw5+LbeFRYh6O5ir8IDZPnt1kZzF0O97Dj0HXqv9frVAYDkpRbw9UHp7nDh0xsBItnelYklDhUHRkK4uUPMBK8yk3nzkYNWl92uFE/Ul4ykIGOGaFAU3RM47S08boEMOyaugA3Q8v5K6Tx783V88+QJCAvd78hJYesE38gk=
Received: by 10.36.41.7 with SMTP id o7mr1941327nzo;
        Wed, 14 Jun 2006 18:14:22 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Wed, 14 Jun 2006 18:14:22 -0700 (PDT)
To: git <git@vger.kernel.org>,
	"Martin Langhoff" <martin.langhoff@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21874>

Things are much faster with 3GB memory. I can run cvsps over Mozilla
CVS in 15 minutes now.

cvsps is making branches named 'Branch: #CVSPS_NO_BRANCH' and git is
not happy with this. Ideas on how to fix this?

-- 
Jon Smirl
jonsmirl@gmail.com
