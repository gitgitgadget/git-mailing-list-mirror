From: "Chris Hoffman" <chris.c.hoffman@gmail.com>
Subject: git-daemon on Windows?
Date: Wed, 11 Jun 2008 08:51:25 -0400
Message-ID: <63c5d3820806110551y69e895eeg4fde4bfdaf22bbf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 14:52:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6PoK-0001pG-T9
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 14:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbYFKMv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 08:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbYFKMv0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 08:51:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:59035 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbYFKMv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 08:51:26 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1443889rvb.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=umsHtdCgW4zPeqkciVGibvIKS/C3H5stSiLwr5XG3So=;
        b=azfYp2lK3A4YIV10gwHpFycdirrk9L8lxO7uOYj+JOnwZ8F2IFcYlZbWF9HQIvOowD
         2jDOYkPCWbCee7uymElgFT1grt1DkNad7aQmtR8y+f2/FPgop/PgUbP7yCKdKBpmpAaQ
         JDDWBuHm+krdrCaZYGMQxMttVmKu0cOVCoxdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=tDGeiqCdd+tjP2kz5SmZzmyODtq75kqEARo7NUOojtZvzxVGb4w+KZXc9GqYc3HB/k
         cy266wZTuanJVAdIvTFAQm1ZOMZb/HYm4GGlqGeCWwMxogdEVJq7gljVTEFLW0nbULjX
         jd9ZTZJAdGiKG9vsA7+IeWmcZXMfs+iMWzV+M=
Received: by 10.141.13.16 with SMTP id q16mr3796768rvi.99.1213188685678;
        Wed, 11 Jun 2008 05:51:25 -0700 (PDT)
Received: by 10.141.87.15 with HTTP; Wed, 11 Jun 2008 05:51:25 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84606>

Hello,

Is there a distribution of the git server for Windows, or am I totally
missing the point of git?  Will a simple file share work, or do I have
to worry about file locking and such (e.g., two people try to commit
at the same time).

Thanks,
Chris
