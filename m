From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Test failures in contrib/remote-helpers
Date: Sun, 11 Nov 2012 18:18:40 +0530
Message-ID: <CALkWK0k9trxx8NC1GWw-yYzBKhFchrvg2JLeBtyoAkokmv9A0w@mail.gmail.com>
References: <CALkWK0mU5O3Rqznkx-qn8VLFEgsMzOba1i8onSvf8X3FBeTs6g@mail.gmail.com>
 <CAMP44s1TLyKoHVouwgCFqi-vwA6rUBYJZXTA7JDFX6bfyQ7_tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 13:49:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXWyU-0000mb-Pa
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 13:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946Ab2KKMtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 07:49:04 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37947 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769Ab2KKMtD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 07:49:03 -0500
Received: by mail-wi0-f172.google.com with SMTP id hm6so1732127wib.1
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 04:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=510z45UiIZ1hoHcncBqXVHCkZrbdlg5y5j4s7JXcOck=;
        b=KEMf4WNvYTqNunNc5P+KFC9VSAe9/Qd3/G5jDAWcmImLv9HFACg2Z+kgXK/+ySn0FH
         9nKxjzplApGXLJIP96OUg1V/j+AiZC3hmnjnQG9SCuLw93xZLwAvHi9H5sUcPwW/5Xvi
         z0sl6Kr7PkQfcUwsPK3FZlqW2PrvARY8GtSGO7tBmo2ewkYoq7uEHM00DjV4Ej3PJmT7
         /8Rp403MtWpSPcF+aC3spbhfDr7MZ2MF5MuhytsAw/kT40aXe6a2LA10rwILERcqOE1N
         ZI8U1zLu/7kt8tPCFO+6xTDdTjhe5RcE+w/aPVSXQeoBJ1seAZhMi1zCzikEN30V06si
         /XBg==
Received: by 10.180.8.100 with SMTP id q4mr10702349wia.16.1352638141186; Sun,
 11 Nov 2012 04:49:01 -0800 (PST)
Received: by 10.217.61.2 with HTTP; Sun, 11 Nov 2012 04:48:40 -0800 (PST)
In-Reply-To: <CAMP44s1TLyKoHVouwgCFqi-vwA6rUBYJZXTA7JDFX6bfyQ7_tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209349>

Felipe Contreras wrote:
> On Sun, Nov 11, 2012 at 11:32 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> I'm experiencing test failures in contrib/remote-helpers.
>
> Which are your versions of hg, and bzr?

Mercurial Distributed SCM (version 1.9.1)
Bazaar (bzr) 2.4.1

Ram
