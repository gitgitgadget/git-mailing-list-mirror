From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsimport: complete the cvsps run before starting the import - BAD
Date: Thu, 8 Jun 2006 12:06:23 +1200
Message-ID: <46a038f90606071706w46567f6j4f4addae5c877537@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 02:06:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo82d-0005p7-UY
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 02:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWFHAGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 20:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWFHAGZ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 20:06:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:6462 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932476AbWFHAGY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 20:06:24 -0400
Received: by wr-out-0506.google.com with SMTP id i20so295990wra
        for <git@vger.kernel.org>; Wed, 07 Jun 2006 17:06:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d2CZzwvpMmTog8SFvpykCeBRSuyev1z1QXAy3aoH7nvTWJdCBwvlRduPmQuR9U7cYLCAhsR2kdtMJSxmOV8EhykyWZFAM2UPQWGfXa17cCf53P7ezOwvyyIeYLHrc5xjUY3lQSPOzzuS7T5HwPwjAkMj7FA0gQ5ECE8Vqg1s0eI=
Received: by 10.54.89.9 with SMTP id m9mr1378028wrb;
        Wed, 07 Jun 2006 17:06:24 -0700 (PDT)
Received: by 10.54.71.4 with HTTP; Wed, 7 Jun 2006 17:06:23 -0700 (PDT)
To: junio@cox.net
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21464>

Junio,

As far as I can see, you had the good sense of not applying this one.
It is bad, and should be dropped.

cheers,


martin
