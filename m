From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: What is the pre-merge hook status?
Date: Sat, 18 Oct 2008 10:42:27 +0400
Message-ID: <c6c947f60810172342n6843b173tb0019d0af706800d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paolo Bonzini" <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Oct 18 08:43:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr5XK-00050P-N7
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 08:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbYJRGm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 02:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbYJRGm2
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 02:42:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:3927 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbYJRGm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 02:42:27 -0400
Received: by rv-out-0506.google.com with SMTP id k40so920012rvb.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 23:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=eFTLl++veCApW9434+hmN9iBvZQLSjhhSxp59f5f7pc=;
        b=dx9i4l9npVNrU3gH3dZSVlSqGv4W3yALScRQH0Ys+Lgb0/NTlTpey2scqTh2gBsd9C
         PxX/1BTSrc35TQR8N7JZSQOjjIp6Tfhu/ky7Voxc/UadxQU1zoM/yBODwwbmBLVqs2RC
         n7yfup5jGhx6jfbN7okDhbEX4zU2Enbm+zzX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=b8GjIFh0fDEIPZ8Fw3/mD63URvzcrwc/JnBQCEMMAiB9bpVnwCFrscmUUtTzdWPtjD
         Ps5hNto8aRdzKdfc1ijdENERFdatptAhosxIJ6NMTRKM6bMENPiOPZO4vhLEC4vlSXX/
         sDTmzASv0Vsgol4ckrU2/SzLF/QGnKdBwyXDg=
Received: by 10.141.197.21 with SMTP id z21mr3099437rvp.91.1224312147260;
        Fri, 17 Oct 2008 23:42:27 -0700 (PDT)
Received: by 10.140.188.5 with HTTP; Fri, 17 Oct 2008 23:42:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98524>

Hi, Paolo!

What is the status of your pre-merge hook patch?

http://article.gmane.org/gmane.comp.version-control.git/93888

I think it can help me greatly with my repository management process.

Thanks in advance,
Alexander.
