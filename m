From: "Tim Visher" <tim.visher@gmail.com>
Subject: Installing git docs in Cygwin.
Date: Tue, 23 Dec 2008 09:39:02 -0500
Message-ID: <c115fd3c0812230639v78cee30cqbc7303b02633c8d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 15:40:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF8Qz-00005R-2B
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 15:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbYLWOjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 09:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbYLWOjG
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 09:39:06 -0500
Received: from mail-gx0-f27.google.com ([209.85.217.27]:42219 "EHLO
	mail-gx0-f27.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbYLWOjF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 09:39:05 -0500
Received: by gxk8 with SMTP id 8so2142226gxk.13
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 06:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=kv53avcjOmDPU57jaPPoQDEtSaI4zVAlJ4iPWaz4nZs=;
        b=o0jvPo5Y1+ZxsBq3xzv5o9gheDOOS1wzyNbAPt9Q8MQ8j38ysDM+dionfBWe73mZ/K
         Vgkg1W98SkvvbSI6eEl8og5g1wLE/QU/6lkPZ0RzeMfgIofFYn0Rd/vCVxKP2XsOguXW
         ffqDscF0l5D2dBhdNKe6TcH9xF97gFpJt8jRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=MyHaYz6EUPymsYM1I9duwkZ5CcPU7zLpGPeGdtIwOlBN6skRDuHzgB+OroSyiGjSHV
         fLbilffLHZ9a+e21LqXjeUZLy+RnOs4ms9nwAKPXTQH01fcY5DrkovbLs4pc/XgnaFiv
         wtS98RxUr810b6FfOfwHKDtUwmamB620tOR+s=
Received: by 10.100.119.17 with SMTP id r17mr4569474anc.130.1230043142615;
        Tue, 23 Dec 2008 06:39:02 -0800 (PST)
Received: by 10.100.198.2 with HTTP; Tue, 23 Dec 2008 06:39:02 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103825>

Hey Everyone,

I was wondering if anyone has been able to install the git docs on
Windows under Cygwin?  I just ran a successful compile of the core
software and everything seems to be working fine but when I do a `make
install-doc`, all of the pages compile fine but then make exits after
exiting git/Documentation with an `Error 2`.

Thoughts?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
