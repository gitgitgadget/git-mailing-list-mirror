From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 0/1] Use absolute paths of lockfiles
Date: Sat, 6 Sep 2014 20:30:38 +0700
Message-ID: <CACsJy8BNSriBAYkdKHEJa3wN_pcFkjzsOUw_1kyMPz0J_2KD+A@mail.gmail.com>
References: <CACsJy8AJvt3bVj783eyHhiFaMD3Ys6pAsyT7S2TYi2a_ACKcRg@mail.gmail.com>
 <1409999489-25193-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Yue Lin Ho <yuelinho777@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 06 15:52:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQG5H-0003iC-LG
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 15:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbaIFNbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 09:31:10 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:62417 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbaIFNbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 09:31:08 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so713166igd.5
        for <git@vger.kernel.org>; Sat, 06 Sep 2014 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SJFVbS7+hDlfONwU4C62/JOpGV6VpUkVwC3eyMpJiuw=;
        b=qZqEeH49z3UFrNBX4SQ1j9EJLCCaAJkGNK6ln/qRtLXaMCNiAW6Ohtzxz/FXJIyDgE
         /ddvPkxmxCQWV4ApiK5ElYZLiIq8md0nrFZu8eSL+srVgyKvmUoQmuRXwYB3/PtiFT5c
         EGjZ7MjkZAMxd4NBf/17Ltz89O8SlEK4pm+LfJX56DlNXkMF/tspuNAM7SJFalIQde+m
         F0jzK8yNBBg0/t8JEUUvvLmhyVnVKul3Qkub3rW1QqKyvRaQselIm6ErsphWV7aKs4qt
         Dptda2bfhH47WjWle4f1jUh33e5G4pm7UtJy1GNTvuhyv0LuIHV/5pSlRtPGd+Fx1liI
         vbdQ==
X-Received: by 10.50.103.106 with SMTP id fv10mr12137045igb.40.1410010268086;
 Sat, 06 Sep 2014 06:31:08 -0700 (PDT)
Received: by 10.107.3.152 with HTTP; Sat, 6 Sep 2014 06:30:38 -0700 (PDT)
In-Reply-To: <1409999489-25193-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256587>

On Sat, Sep 6, 2014 at 5:31 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> So I've shamelessly labeled this "v4" of his patch series and I've
> left Duy as the author, because his commit message (which I used
> directly) has far more intellectual content than the code change. Duy,
> if that's not OK with you, please let me know.

Not a problem. Thanks for picking it up.
-- 
Duy
