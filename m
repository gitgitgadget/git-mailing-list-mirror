From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Why git shows staging area to users?
Date: Sun, 14 Oct 2012 06:08:36 +0900
Message-ID: <CAFT+Tg-g6KOs3YUKV_GWbZiO9qUG3LP8-T3Tdyd3LinnheQZ8A@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 23:09:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TN8x3-0007us-O3
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 23:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab2JMVIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 17:08:37 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58834 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab2JMVIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 17:08:36 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3895941oag.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=JiheDwhdZF0qhBWQIatzbgATc1k9cv2vUyqZcksLDyM=;
        b=XRIqEI0UYtIoqJc2HeMyX/FAdQymoAnXC+DMjI4rTRsEqIZkdo4ckrwXd2tM0RDjSU
         5UYhrlSe1D34KvSvw0EIeVDTBJDmhPKudSJcVJQ787gL6kFawkGyeavuk93+7NuThevB
         ZvKhveGYajaKuOOmAGNIRPcU42CcXYot4EhfYFIOKSw7OubA77jwDGxDfixZCPj8NsdT
         1HutC8QjhqkUDieB2noacZGRujNaeTQ+XhqufHhBncYXPJzSXFMtl77mQxir13OZdrza
         Y36f3P8MScSZwkMDDEBw/iDCTxBSOQN/2urbNrSCYr8CgJPbl8atvUVJm67Yu8a5FxEq
         mnEw==
Received: by 10.60.25.228 with SMTP id f4mr6369633oeg.29.1350162516232; Sat,
 13 Oct 2012 14:08:36 -0700 (PDT)
Received: by 10.182.73.3 with HTTP; Sat, 13 Oct 2012 14:08:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207577>

Hi, all.

Why git shows staging area to users, compared with the other scms hide
it? What benefits users get?

I feel staging area is useful, but it is difficult to explain why when
someone asks me about that.

Thanks.
