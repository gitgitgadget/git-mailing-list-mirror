From: Prasad Karmarkar <prasad.s.karmarkar@gmail.com>
Subject: git log reliability
Date: Mon, 17 Dec 2012 14:56:17 +0530
Message-ID: <CANirugRmpoGb=T1V2ZBw3GEE5nYwD-hyLOfWgt-UVvMXh-i_OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 10:26:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkWyA-0008KD-BN
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 10:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab2LQJ0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 04:26:19 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62447 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab2LQJ0S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 04:26:18 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5667574oag.19
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 01:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=V0RgpLmM5InbC1T2GLcAs7IwXNSyzPmovtuQqlc5oxE=;
        b=SNZrk7CVlIzAFRHencchU1TcNX45VYuwic8ahmNkNfrXnzcKpVxVHE+viLl87394EE
         Kx9nVaE6r64toQ7m0JSut9abVUiOf1L8V9K/mpoihvH3dA3z1Jd8DwRdwnkEXYZahM14
         Wf8wvJ7KtEmeN+4H+5c5Rxh5WT0kihTTVkeUKQEzTrNU+hyf8RDZZx8tFtTCxcfKHlgC
         NpQjTsZPdTyJqdpmjT3ScaeHOZwYUX7f/ezwIqiRWfKQ/Qc9CidCLE/koP1GrDCOdIdo
         eHUeZsZBiwuhCX31ioL9vogUI+X4hiK9m0/z6Hxb+BYo7Pa0/pP8SzCrkvTCMcBZEVQW
         aFYA==
Received: by 10.182.17.66 with SMTP id m2mr11125758obd.86.1355736378016; Mon,
 17 Dec 2012 01:26:18 -0800 (PST)
Received: by 10.76.27.34 with HTTP; Mon, 17 Dec 2012 01:26:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211666>

Hi ,

I have been hearing from my Release Management that git log is not
reliable. Is it so ?
Is there a known instance where Git log has missed out on commits ?

Any information about this would be really helpful

Regards,
Prasad
