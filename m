From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Why git shows staging area to users?
Date: Sun, 14 Oct 2012 02:06:39 +0200
Message-ID: <CAMP44s2d_3rciA2QTy5vn0yNXEER90-y1Q_x8sn7+2mVJ2eoBA@mail.gmail.com>
References: <CAFT+Tg-g6KOs3YUKV_GWbZiO9qUG3LP8-T3Tdyd3LinnheQZ8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 14 02:06:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNBjH-0002ZJ-75
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 02:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab2JNAGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 20:06:41 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60858 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab2JNAGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 20:06:40 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3953654oag.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 17:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lNstg+6h2YrWLxj6p9N5fcpbV97Kh5CBY8qjXXbDZsA=;
        b=B3tlK6RZOPnv1bKMhux+vjl+X/zgl+Mb5t8vuwC4Lk1dentNjYhdVJV+5oUfZfY8UO
         WlH/VsiifZxPc+n3Xgv4livATtb9Pg6zg/LTUHicuo4Sxu1Tw0PGeueNPEQSANxRrpyn
         w5IKmRutqxvxZh5JXvmoEKAyJ3gJRHn+Z9wyNtAM06ryTm+5fya5WqE3s/l6YffFcXj8
         GVzEPp066oUIrcj6VEN+ChAjB/VETi5Z7vBapMs15OqvFQKNUnqzqZv34ihv7s83yJIl
         ldTBpfr9jd2TaM/JlwF1V0zkLDEHU/fd3IUG0S+qtDVRDJbnnZUJkeToez3bQi9pEo/e
         mzqg==
Received: by 10.60.12.233 with SMTP id b9mr4737978oec.95.1350173199854; Sat,
 13 Oct 2012 17:06:39 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Sat, 13 Oct 2012 17:06:39 -0700 (PDT)
In-Reply-To: <CAFT+Tg-g6KOs3YUKV_GWbZiO9qUG3LP8-T3Tdyd3LinnheQZ8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207588>

On Sat, Oct 13, 2012 at 11:08 PM, Yi, EungJun <semtlenori@gmail.com> wrote:
> I feel staging area is useful, but it is difficult to explain why when
> someone asks me about that.

I agree. There has been a lot of discussions about how to improve the
UI to make it more user-friendly. Maybe sometime.

-- 
Felipe Contreras
