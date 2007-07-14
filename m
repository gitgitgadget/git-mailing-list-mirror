From: "Satyam Sharma" <satyam.sharma@gmail.com>
Subject: Confusing language in man page
Date: Sat, 14 Jul 2007 23:38:05 +0530
Message-ID: <a781481a0707141108g4664a627w94e0d21c3629cb49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 20:08:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9m2Q-0001or-QZ
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 20:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758610AbXGNSIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 14:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758706AbXGNSIJ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 14:08:09 -0400
Received: from nz-out-0506.google.com ([64.233.162.236]:14586 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758563AbXGNSIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 14:08:06 -0400
Received: by nz-out-0506.google.com with SMTP id s18so644656nze
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 11:08:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=r46xRSgNj8kBGV/jDl9jFl07q9JhQXA7sJ3mFiaRFVOxX0nzteNI0/dBl70yDNyEdvimVMdJatw4bO0CbROcHkZCQiiw3/C5WsMj+RxG9kHoTqAX27QKB7zt7F4BSSEnYNyTPwnznO2c5LbepbyFj1mWmidUqfsSPKEa8TcjF9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IwmisRIFO+Fmy9nZh9NfDMu1j/4/s4wTv/XTbo+qXqx7H7taoke9zDMkz59yziLHKYJwsbbcCeLjdR3NTHvJ/1R38ZoUMlyfFbWSPEme7dTFcDlUfizXBf15tHACU3hodc5knAH4YtRv+SYZowTNmqLl9ROFeRku6tiD0fME53M=
Received: by 10.143.16.9 with SMTP id t9mr209435wfi.1184436485880;
        Sat, 14 Jul 2007 11:08:05 -0700 (PDT)
Received: by 10.142.83.19 with HTTP; Sat, 14 Jul 2007 11:08:05 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52491>

Hi,

[ I'm using Fedora's latest package. ]

>From git-checkout(1) and git-branch(1):

-l     Create the new branch's ref log. This activates recording of
all changes to made the
       branch ref, enabling use of date

I'd be glad if someone could explain that a bit more verbosely in the man page
(or just here in a reply), or at least make that grammatically
correct/readable :-)

Thanks,
Satyam
