From: Adam Spiers <git@adamspiers.org>
Subject: new screencast demo: git-deps facilitating porting between branches
Date: Wed, 25 Feb 2015 19:05:09 +0000
Message-ID: <CAOkDyE_ZwWJHxomG8Qk5PE-6nzxhWx9drR_3_6jBLVdHq+u+rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 20:05:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQhH0-0002zR-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 20:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbbBYTFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 14:05:13 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:40767 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbbBYTFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 14:05:10 -0500
Received: by mail-qg0-f44.google.com with SMTP id j5so4749491qga.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 11:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=cxytXXB0w32m0WhkUojI22Pst3rEEWFgjxxj5DRUo+M=;
        b=uAuXcfGVmv7r6vUpS77uirQu1/7jx1brI75t1cWkZfpRTEY2qjFYlSQQ6FZrn0CkBS
         TaaIj2YC2Wyrw4vOkkwZ8M3gFLsK+YO9vi88OQP/5lnc2LGrZA9NZOOrsdiL/1f2ubjO
         tDRSrHSrC+h+NfU9KcUx+U5XkEnaKT+EL8xKPrAOaH4O1aUJGGwK7oquEkJqoqo3LSeD
         fFXR5SWUzPMhwlZX3PHYUGsCklZ/oMXIdWDVCW+bOjns4oUa+Ik8oSgAF7+bA/HdOzQc
         xLA4SQOP7kGdih0mKJmqFJG7pvKVmnny5JJj+3a+t8Ex8SScSc11FE/ZxN7xMduyXyBL
         pcqg==
X-Received: by 10.140.48.133 with SMTP id o5mr9994094qga.8.1424891109849; Wed,
 25 Feb 2015 11:05:09 -0800 (PST)
Received: by 10.140.149.70 with HTTP; Wed, 25 Feb 2015 11:05:09 -0800 (PST)
X-Google-Sender-Auth: zfic738ex6E1GE34DcXIC_gyyz4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264405>

Hi again,

On 19 January 2015 at 00:11, Adam Spiers <git@adamspiers.org> wrote:
> I'm pleased to announce this is ready for testing; here are more
> details along with a short screencast demonstration:
>
>     http://blog.adamspiers.org/2015/01/19/git-deps/

I just quickly made another screencast demo of this tool, this
time focusing on porting commits between branches:

    http://youtu.be/DVksJMXxVIM

Hope that's of use / interest!

Adam
