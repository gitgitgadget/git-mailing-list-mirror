From: "Christian MICHON" <christian.michon@gmail.com>
Subject: how do I remove a tag on a remote repository I pushed to ?
Date: Wed, 2 Jul 2008 14:52:58 +0200
Message-ID: <46d6db660807020552x400b8f3x81f8bf6970729b0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 14:54:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE1qd-0000iG-G9
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 14:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbYGBMxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 08:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357AbYGBMxO
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 08:53:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:13144 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbYGBMxN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 08:53:13 -0400
Received: by wa-out-1112.google.com with SMTP id j37so227845waf.23
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 05:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=52A+nO0M9U6ctVaw82RtT+TkXaY4tLXIEfiQPiWhyNI=;
        b=B66Krn7hjLtz1xRBiJ8gOFsqV1HrBwthWgfLpf2LiUs5DC6BxNhhX3w5P63wcoSyUE
         jdQGoZFlokOrOwwt+iTQ0XtWtDZqUaIV41EiNso5Y8UD8zD1D2pdlJ0Ue3pNJCWMvoyx
         7epBqjU264DFrtnqdLZ40RAMDiEFt5kdRiv6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=RU3A/QUGGtUizxHBJd32Yinro6ydADnL/XKNEGoKzF3lQIQMe4gLf+H2aBfhs64hAl
         wCwuuqgK0MG6j2rC7drjO36Kg1nw2LizApLsKnbQmlZxN9ejYWtKHcFII1U008tYdUui
         uzTuLdjfIMQWMAjAvR/x68fgEnhBRSLWbhryg=
Received: by 10.115.15.5 with SMTP id s5mr6991584wai.6.1215003178690;
        Wed, 02 Jul 2008 05:52:58 -0700 (PDT)
Received: by 10.115.16.17 with HTTP; Wed, 2 Jul 2008 05:52:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87130>

Hi,

I've a repo on github and apparently I used characters not accepted by
github web interface (if I clone the repo, it's ok).
This is a repo where I push to.

I've seen here how to remove remote branches, but was there any hint
on how to perform the same removal on remote tags ?

Thanks in advance.

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
