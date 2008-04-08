From: "Abraham Arce" <abraham.arce.moreno@gmail.com>
Subject: git cloning fails
Date: Tue, 8 Apr 2008 08:00:20 -0500
Message-ID: <cb8016980804080600se489c8bv5b79186be284163f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 15:01:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjDRh-0002eR-BR
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 15:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbYDHNAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 09:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbYDHNAV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 09:00:21 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:19889 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbYDHNAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 09:00:21 -0400
Received: by an-out-0708.google.com with SMTP id d31so438705and.103
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=rnlUFaezGrDo7PbX8orjYfq1D8/NuCYIPsqby/LS5qY=;
        b=T/ho5+/PxMl4n+O8c5HlkfNG60bBFrTzWl7MQ5wvpG4YJvUKd2HHrXchY876nx6dKkeymD/4wIkOnpHLiPb9dWR2GyZV4WOnyrFB9gdW9cuu/IBf1Jcu+XFQ6VD9/gMin7tGPpjT/N7sVTcaYGDHOc97UWbQLSoyPVx8aR/oKUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M/nLfA+94qpCHflr8xFgNu2boUS8Er9QREEflwrDOhz74zJx7pZJQfcB9BJr+0GhQOG/02RozU7WkvAZ1OwjGCqwP/LTPIU+mfm8AkEYo0MsS3E8KavS+CdhETyXxTfRmVvQvefAToNh2uNoZ9NbL1S0SUWupu+yx7Z7cvB47m4=
Received: by 10.100.4.1 with SMTP id 1mr1525634and.146.1207659620101;
        Tue, 08 Apr 2008 06:00:20 -0700 (PDT)
Received: by 10.100.12.8 with HTTP; Tue, 8 Apr 2008 06:00:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78997>

Hello,

While cloning git repository

git clone http://www.kernel.org/pub/scm/git/git.git

I've received the following message:

got 33682a5e98adfd8ba4ce0e21363c443bd273eb77
error: Couldn't get
http://www.kernel.org/pub/scm/git/git.git/refs/tags/gitgui-0.6.0 for
tags/gitgui-0.6.0
The requested URL returned error: 404
error: Could not interpret tags/gitgui-0.6.0 as something to pull

Any idea?

Best Regards
Abraham
