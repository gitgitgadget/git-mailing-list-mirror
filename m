From: Eugene Sajine <euguess@gmail.com>
Subject: plain text only policy prohibits the use of android based mobile devices
Date: Wed, 18 May 2011 18:03:49 -0400
Message-ID: <BANLkTik5g+oahTuTZ5BSOunQMfzGNRZ-7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 00:03:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMoqU-00019D-T5
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 00:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200Ab1ERWDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 18:03:51 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45118 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093Ab1ERWDu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 18:03:50 -0400
Received: by wya21 with SMTP id 21so1541848wya.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 15:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=CkM6dVyfQ2ur5Rs/PGmHtFHD5QoT8KR94mJ9mJB0gUw=;
        b=dofgh1yauqC7SMgb1/ef7wV1cRsHc5DfHAMTeY7n8SRe3N4sm6SqPSSW7yOhlzI4Pc
         6asVa6ns4Eu3uuf9XRS2hMyPJZ64/hzSvBP8S/ITpPg+X+BS+vJwBAGPEwt48mrPATHB
         ZKvG1NP9KRNtuy6YRwoDjKWRd0wJ45Nt/iLTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=SGfMdZvIsKw9nY0gcyeFh2I63XWgsTa6l9u1+gG65QPTprfvICRF+W2xcIRcnMYYVP
         +WtpQEJ5uLel3WIHeWuFhtRoEsJ/zpX3lMXXxp3280DZKdVheTDb6XxcpG5rZCvc6tBT
         lg2yCioKRp0xtLM3V0vrT9VBhULDvieKkB5xs=
Received: by 10.227.196.143 with SMTP id eg15mr2369481wbb.107.1305756229090;
 Wed, 18 May 2011 15:03:49 -0700 (PDT)
Received: by 10.227.12.209 with HTTP; Wed, 18 May 2011 15:03:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173907>

hi,

Due to the existing policy about plain text only messages accepted by
the list it is impossible to send an email from any mobile device
using gmail native app. The problem is that Google for some reason
doesn't include plain text email sending as a configurable feature in
Android v2+ and only sends multipart HTML and plain text messages from
Android 3.1+ devices (AKA Honeycomb tablets)

The necessity to use the desktop in order to send a message to the
list is annoying and not quite contemporary.

In the same time this policy doesn't seem to cut off SPAM effectively
as I'm getting plenty of different emails of stupid nature with git
majordomo or whatever it is signature inside.

Can the filter be made smarter to accept at least the messages from
Honeycomb devices 3.1+?
Is there any other steps that can be made to make the list more mobile-friendly?


Thanks,
Eugene
