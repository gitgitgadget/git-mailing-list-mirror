From: Bjorn Boulder <bornboulder77@gmail.com>
Subject: Rails code to serve git repositories?
Date: Fri, 3 Jul 2009 04:28:45 -0700
Message-ID: <a6591d550907030428w175ba2ajb4bef8e906a2de5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 13:28:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMgwo-0007BN-V1
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 13:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbZGCL2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 07:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbZGCL2n
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 07:28:43 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:64746 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbZGCL2m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 07:28:42 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1055716qwb.37
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 04:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/o3PW71hBCK2IH4NKBnJWq6k49c/2Ad5D7mIQdyf2ps=;
        b=A+cVowvyIazjwN88A9aM286r8Aa5VCNP9X/mEsrLbW2fJAdzJZjOF5sQkkhr+WSdnu
         5jnyNXBMpnlb1mD6LFBTCV4JhwqL01jfcdUGQkxjvWB6tCM2w3dmLSqhaYQuF6QNnDu1
         NSXFvorJS0G+/m5ANNAjrTiAD8KKsY4k0Ki54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=rb0H+RaDWINL2en810eYaXppvq1vW5gcg8fPhAXc8/bJhG8w+nbmdH6u2+A4eS+wK7
         ptK5QtA5FDS7Ia44XotRDQhBERE9jfheuWt3Pf5lB4yFHFIyIEkgcCQZbeDbbYSeboKM
         iqe1J55TxCZNYqJY4NhUHorRWhAjMLVpfm3Ho=
Received: by 10.229.89.202 with SMTP id f10mr947749qcm.71.1246620525778; Fri, 
	03 Jul 2009 04:28:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122695>

rails and git people,

I am searching for some Rails code I can use to serve git repositories.

Please alert me if you know of any projects which have this use-case.

In other words I want to create my own github.

thanks,

-bb
