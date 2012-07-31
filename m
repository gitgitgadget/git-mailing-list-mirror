From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: Centralized git
Date: Tue, 31 Jul 2012 18:25:27 +0530
Message-ID: <CAH-tXsCGxpqP+C2CiCCB88exMT6H3w0id-otFWPRXrhhreRfWg@mail.gmail.com>
References: <CALZVapnwGK=cKdHbZRsN0Ust7TAvFqa3AmYD7pzgoxdDxQh+uw@mail.gmail.com>
 <CALZVapkUu+hckMRAaNULSW5s9Q7P+78eVt1Q+ZrKFdPYb5uFVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 14:56:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwC0G-0002qx-8U
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 14:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342Ab2GaM4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 08:56:42 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:59185 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212Ab2GaM4I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 08:56:08 -0400
Received: by wibhq12 with SMTP id hq12so3309157wib.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OfuAdN5By7C/yuVQ5XtuS8hPAMgO3ztJY7l/zcRvKZw=;
        b=SDWsK0+qY/qwvJJjSbvHppyuyG4IAC7iS9XjrWazlLFJeQu0zGCWAgTb0fI2WJV8GR
         Iz17W2DAQ1sJ8zK6G0V1uV6OIBE5Cld6yfCRDLURQgeGfr0q+Oe5Lh92xSLHjhWcdm13
         Q/xopfp09tW7tvpy9L4wBTpahnS152hrykHBLMobPQWqRvVxo/q2+pY/g5Jypq36uTX5
         l+bNPl+hI0321LzhET/K/2eGko8YV9sGqYfJ8/bDtbVy3Ig/vkTd6TKUIC06Vcl8vS43
         /Ndu/Z5hs8cRn5ZAis04vGJ+O2E75ImACTW0AXM4X+IBryU9MtD+uxwUjCnTYFTtgi6h
         e6xw==
Received: by 10.180.103.4 with SMTP id fs4mr6638926wib.16.1343739367303; Tue,
 31 Jul 2012 05:56:07 -0700 (PDT)
Received: by 10.227.30.133 with HTTP; Tue, 31 Jul 2012 05:55:27 -0700 (PDT)
In-Reply-To: <CALZVapkUu+hckMRAaNULSW5s9Q7P+78eVt1Q+ZrKFdPYb5uFVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202652>

On Tue, Jul 31, 2012 at 5:33 PM, Javier Domingo <javierdo1@gmail.com> wrote:
>
> I am currently planifying a 3D project, and I will be having large binary
> files. If I add a distributed VCS, the amount of disk space required will
> increase significantly.


You are going to transfer something that wont fit into your hard disk
up and down your network once in a while ?

I assume disk to be cheaper than network.

--
Jaseem Abid
http://jaseemabid.github.com
