From: "Assim Deodia" <assim.deodia@gmail.com>
Subject: On running git via proxy
Date: Sat, 8 Dec 2007 10:43:40 +0530
Message-ID: <fcf013560712072113s6b41b437t3176412356e258a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 06:14:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0s0n-0000ET-QU
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 06:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbXLHFNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 00:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbXLHFNl
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 00:13:41 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:47410 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbXLHFNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 00:13:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1905566wah
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 21:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=7cB31tecpUvBKWhDWIQnFyRkQZWnHu1gfI0rUn4Tiww=;
        b=UMZt6eHU5+m6/D2XUAapkyz4glzXlGGgvXMruQHr5GF33fLkFgRPgy7xXSsj2/ei8w/F7xc/7YwdobtYUe8Q9dhsdft+4DxpRst5nEWMX+yiR/825xdR9EwVpLrqT06luZvjRm2kyokUli/rHGXMDCj1cEMERfJCGNkGwJY+jGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=EwjAhjp9/DCB6RDkwzZR0oLeXWnVEUy8Xeikuffc59gfe/1+Ahh4TB7DEbXdCggTNd5xwg31ePdpLvBAzAHZA2pp1UkVwYHLy4IAVqGRoKSGtwAEQ+KR3E+5Nyn7ZOKfMXEfnEU0Wm+YvJ/JHX4aTuWY3reMJeY9yhpE+jp6HXk=
Received: by 10.114.158.1 with SMTP id g1mr4435112wae.1197090820087;
        Fri, 07 Dec 2007 21:13:40 -0800 (PST)
Received: by 10.114.75.8 with HTTP; Fri, 7 Dec 2007 21:13:40 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: f669f0df8e996352
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67516>

Hello,

I am a newbie to git. I am running git on my virtual machine which has
the internet access via proxy through the host machine.

I am unable to configure git to run via proxy. system proxy seems not
to be working for git..

Can you please guide me for the same?

-- 
With Regards
Assim
