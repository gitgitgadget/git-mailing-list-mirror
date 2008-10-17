From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Weird filename encoding issue
Date: Fri, 17 Oct 2008 11:59:20 +0400
Message-ID: <c6c947f60810170059s3859d906r9935b5e80d8a41c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_30632_7206474.1224230360465"
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 10:00:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqkGB-0000rG-AM
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 10:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYJQH7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 03:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753345AbYJQH7X
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 03:59:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:23740 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbYJQH7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 03:59:21 -0400
Received: by rv-out-0506.google.com with SMTP id k40so422158rvb.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 00:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=jul3NFVlQLM7igYglfVSmlG6hhMq7hcMktCneB8HPo4=;
        b=U/ItuZownqBNE1/dXCr3kGg80NOzzUUG7yNoSI7iwKohWTBvKSctULgVl17ztreC6l
         v2jHgYf/YlO+Yp7wPrsXb024UHQE8Bx+Jpkmr//H5331fJWMNga+PT7vBrFltkBCtt6Y
         XEuhxUwEhzDS1GAaP9i7mMSBZK703SwADUpk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=ogC0rD9XDgLPZ2ARYknH/uUNThL46QMbfL/Rw4MwFGis05L+08WQ9jI9cB+uRJ9GJt
         TZjCg7pRJmhMnCf3SXM/288mQnQZtMyzvGlqBaYqxP4DtSrl2HkmN18d87qS7+LYL0Vv
         Nk85tvh5Gw37UGWBb0JvASF8TAQQMmm0/2J3k=
Received: by 10.141.114.15 with SMTP id r15mr2316099rvm.164.1224230360472;
        Fri, 17 Oct 2008 00:59:20 -0700 (PDT)
Received: by 10.140.188.5 with HTTP; Fri, 17 Oct 2008 00:59:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98456>

------=_Part_30632_7206474.1224230360465
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, all!

OS X 10.5.5 (English locale), Git 1.5.5.1
Windows XP SP2 (Russian), msysGit 1.5.6.1.1071.g76fb

------=_Part_30632_7206474.1224230360465
Content-Type: application/zip; name=Copy.zip
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fmeisni70
Content-Disposition: attachment; filename=Copy.zip

UEsDBAoAAAAAAGdZUTkAAAAAAAAAAAAAAAAJAAAAiq6vqO8udHh0UEsBAhQACgAAAAAAZ1lROQAA
AAAAAAAAAAAAAAkAAAAAAAAAAAAgAAAAAAAAAIqur6jvLnR4dFBLBQYAAAAAAQABADcAAAAnAAAA
AAA=
------=_Part_30632_7206474.1224230360465--
