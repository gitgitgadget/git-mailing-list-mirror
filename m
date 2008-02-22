From: "Maxim Gordienko" <mgordienko@gmail.com>
Subject: [GIT-P4] usage under Windows
Date: Fri, 22 Feb 2008 09:44:41 +0300
Message-ID: <96c268400802212244g7fd2de2bj6c1b7022885c8e89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 07:45:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSRf4-0002gA-89
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 07:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764874AbYBVGoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 01:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYBVGoq
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 01:44:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:25552 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764874AbYBVGom (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 01:44:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1211702ugc.16
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 22:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=dL8FrBmsuiW0twCHkLzuGZbOI1tvqMM2CvSAhqE8Jx0=;
        b=hP9nl+k2GWpMtM63jbfL1V5jLPz0WcCKxle/3YqGYJE6+ln3fMWh8Bd6kOelExFgixdnuRsYCrI9vpb9MVwZG2T7yoWBT3mpakj4ol+Q8RvnvtG0wCuEiFmgZK3a8VRK4g5pvDMedXzE0GgehrR+/8zbXARbTPRs4Jg/oqOFoA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rzfTLzXv6zD193k6geWT4VC9VokpHqF1f8pkXGvJnKdpoitw3/N4M92bxa9XZ/e7ny70PPS5J2AbJsp3waOAZLnd+mpm9QyhkbqhyZQzYZB5Q9Feg1tep8eIX9iYseZIir4H5Fnlw3y3oQcTLLxpi55MUmztxecZ8ob0ODnqZF4=
Received: by 10.66.243.13 with SMTP id q13mr1942459ugh.59.1203662681158;
        Thu, 21 Feb 2008 22:44:41 -0800 (PST)
Received: by 10.66.252.19 with HTTP; Thu, 21 Feb 2008 22:44:41 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74694>

Hello!

What are best practices to use git-p4 under windows?
What p4 client should i use, native or cygwin one? Is any special
perforce client configuration required?
What python distribution is preferred, included in cygwin or active python?
Where i need to put imported directory under perforce client' root or
in any other place?

Thank you!
