From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Sending a patch using git-send-email
Date: Wed, 9 Jan 2008 09:29:53 +0600
Message-ID: <7bfdc29a0801081929i5b8c9cc6i9a8b6aeb38f22027@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 04:30:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCReF-0006w2-87
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 04:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbYAID3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 22:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYAID3z
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 22:29:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:30844 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbYAID3y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 22:29:54 -0500
Received: by fg-out-1718.google.com with SMTP id e21so87875fga.17
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 19:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=tJx2b7SqObKzWtJ1U2o6FtD2PUVNw+FxpDjlpBowV10=;
        b=Y6SglvEawT8ajvCjgPPzSa0MX/TMmsKK1GvxxpVLQZSdML8RgGsFv5wqW+bh3jn3L2bL5RYrXEeU6heF99cZ6TzWKlbahvkZWiQvj+JCOIWFHMchIi9TfFAIFTibHfK/Fpf0IQMEM+YGI1aVlkdZ82yZvNOPf+LP2e7kWCVZp10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kGiox/5aRbkOv1wlpSqiOH3WJMgaFkbjmT7Wf41jjXtAKdCDNiX/2nyzmDsTF+potGkYp+oM9qIl/1hLUE7n1JtPLskeHjtKLdf6z3oCiwm7ac4xyPzVk6uKGsJMuxma12XD0VaSqA5c/tMyOa8YAOaO+vDGIZe4MHmJi4VX/Gk=
Received: by 10.78.138.6 with SMTP id l6mr64412hud.32.1199849393116;
        Tue, 08 Jan 2008 19:29:53 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Tue, 8 Jan 2008 19:29:53 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69948>

Hi All,

I am using
git-send-email --to imyousuf@gmail.com --cc
imran.yousuf@smartitengineering.com --from imyousuf@gmail.com
~/Desktop/0001-Signed-off-by-Imran-M-Yousuf-imran-smartitengineer.patch
to send a patch, now if I use --subject "test subject" --compose I get
2 emails one with subject "test subject" and body I gave in the
composer and another with patch subject and the patch as body. Is
there a way to combine them?
git-send-email --to imyousuf@gmail.com --subject "Simplified action
invocation in git submodule" --from imyousuf@gmail.com --compose
~/Desktop/0001-Signed-off-by-Imran-M-Yousuf-imran-smartitengineer.patch
was the command I was using for subject and compose.

I would be grateful if you would be kind enough to help me as I have
several patches pending to be sent for this.

Thank you & Best regards,

-- 
Imran M Yousuf
