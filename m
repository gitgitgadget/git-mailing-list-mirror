From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: Can I forbid somebody to pull some branch or tag from my repo with git protocol?
Date: Wed, 17 Dec 2008 17:03:07 +0800
Message-ID: <856bfe0e0812170103w1007cf4fs1e83e506c6dd909@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 10:04:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCsKU-0008Kd-Rc
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 10:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261AbYLQJDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 04:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755909AbYLQJDL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 04:03:11 -0500
Received: from ag-out-0708.google.com ([72.14.246.240]:49795 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbYLQJDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 04:03:08 -0500
Received: by ag-out-0708.google.com with SMTP id 31so3121879agc.10
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 01:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=e3oolkDWawLZbDXZW1JHotPfAjPShSXDW0wNkbk/mfQ=;
        b=fB1p0ZjKKjkdIFdo/87dMeQDU+lM/8Z9CXh9ArM41RvumsSh0ienhje5FHK7SKPrw6
         UhR67cIkSTd9qLJgowXsQFCq4pya9ymFedSQWRpZkmf+KqHvrVWM/rTzbhAonqhtLNaL
         OaGF3cey6HZuHHN5wIruaOYpqHSp6l8ChqOSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=j9TxkqHXCoxD92BL8/KqLxyyjyVVc+mD0z1VU0PBbZ8eBCGh7IAtdKHa4+eG2vVc8e
         FEkK0Mnldd2N1P4brEaOJrIhBD3WWuKmji5xxD5EY/M2+06ZQ6MJVD+YTkt9gCFs1wuZ
         etkydRziCzEATzNgk4wRkCL53TugxhZ+cvQaQ=
Received: by 10.151.143.3 with SMTP id v3mr986913ybn.101.1229504587191;
        Wed, 17 Dec 2008 01:03:07 -0800 (PST)
Received: by 10.151.11.2 with HTTP; Wed, 17 Dec 2008 01:03:07 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103323>

Hi,
I created a repository, and I don't want somebody to pull some branch
or tag from my repository with git protocol. How can I do ?

Thanks,
Emily
