From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 11:48:53 +0300
Message-ID: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 09:49:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZj8L-0001HT-Kc
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 09:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYCMIsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 04:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbYCMIsz
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 04:48:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:28666 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbYCMIsy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 04:48:54 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3892686wah.23
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 01:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=/7cJ9O9JCUbc4mn/DSkSZDPJ2VX4sJuuLlL/amA5EdA=;
        b=gbeZb6pHHiY1+/RIKeJdLL1VIlzaJ3lE9b9gRH7XiFDiMR5pSiPFgXekB4tgN3KEGVNjs/aIOFuNLXb+yMlRh7gX3qGSZKLABmWXl2R5iptBvbqwPoHELey3Jk2jN/Sx56buWXBuYLmJPhaCWa6eS/ULWgWige1cIGQ5MYHO5TE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aR+VSBIyAPuUVMCl+tojqACUOk7+E0y2taG7WBmGYFy0kwxV91cdR+IAHC26aQCAllJ16NjJUl3q1dRUqcPKW37b+S1qOoxqwTwLNzgRtUo6oH7K8cgyLCY3DXv0rbIWW7dPH0aBrHk6OXzLCaTWabbGGwtoodK8GfMEjJmB20w=
Received: by 10.114.255.1 with SMTP id c1mr8873067wai.93.1205398133531;
        Thu, 13 Mar 2008 01:48:53 -0700 (PDT)
Received: by 10.115.111.4 with HTTP; Thu, 13 Mar 2008 01:48:53 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77054>

Hi, list!

I want to create a private GIT repo (without working copy) on a
machine in external data-center. While I do not actually believe that
it is possible that someone who has physical access to a machine would
be interested in peeking into my repo, I'd like to play safe and to
have this issue covered.

Please advise what is the best way to do it. Are there any existing solutions?

Thanks,
Alexander.
