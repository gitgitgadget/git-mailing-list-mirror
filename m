From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Test failures in contrib/remote-helpers
Date: Sun, 11 Nov 2012 13:00:51 +0100
Message-ID: <CAMP44s1TLyKoHVouwgCFqi-vwA6rUBYJZXTA7JDFX6bfyQ7_tw@mail.gmail.com>
References: <CALkWK0mU5O3Rqznkx-qn8VLFEgsMzOba1i8onSvf8X3FBeTs6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 13:01:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXWDs-0007hw-Tu
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 13:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab2KKMAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 07:00:53 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:63602 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab2KKMAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 07:00:52 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5426214oag.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 04:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XC9dseMtET1w9alNQUCPr+OJf3PkweuZYu+AianhhYs=;
        b=cDLdKH4L6MYsQ44msNcicsKW2bdb7LEAgwSsyWfZuSAti7bBaG3g13d63duiACfQvM
         FMFGHqTS7cuMsxG3JIDpO7/hIYB+cgmyr89sZ4p4g98QUKyC/2kHm2Mfb6xpcfRRImBy
         kFsta6ZZHNaWgMDmnOZfj5SsiEmLfNx8hpJAzjRQETgeDd19haLJmJ2FRIlOFQ7rBQLf
         irEcu60bg6+T11s/x1/65xWVFqnSPWZjcWN/ByUVT8P72q2RIbn1vt0JvaD63RalrR9z
         zmP4pvS5rlTfhjdgJkzYa3kgWE8meLsO/2Q6KoOe3/b8bjtSMwSm0+i+N+i59G92WsBj
         qFoA==
Received: by 10.60.31.241 with SMTP id d17mr12081023oei.107.1352635251629;
 Sun, 11 Nov 2012 04:00:51 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 04:00:51 -0800 (PST)
In-Reply-To: <CALkWK0mU5O3Rqznkx-qn8VLFEgsMzOba1i8onSvf8X3FBeTs6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209342>

Hi,

On Sun, Nov 11, 2012 at 11:32 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> I'm experiencing test failures in contrib/remote-helpers.

Which are your versions of hg, and bzr?

-- 
Felipe Contreras
