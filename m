From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4 01/11] Add new git-related helper to contrib
Date: Sat, 27 Apr 2013 08:31:21 +0530
Message-ID: <CALkWK0ks0yveTus9w=4MFoCjB6ujUUax4_o48Gy_yevyT6BeyA@mail.gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
 <1366919983-27521-2-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s0nvWvicFAJEqe0jC+zT3ZvA=Qx3MWXK36zYb2-uYV-aA@mail.gmail.com>
 <7vhaisvqvl.fsf@alter.siamese.dyndns.org> <CAMP44s0XnEJWjzU-g=Gq2jJQu-9MJ8S84fAd-7bdomKWEeTCtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 05:02:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVvOq-0003us-3R
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 05:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab3D0DCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 23:02:03 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:56727 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab3D0DCC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 23:02:02 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so5544773ief.7
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 20:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=J8aXh6ijROESUtIVjJw37GR7mnvjShzQEJEu/ZsfDLc=;
        b=RmysDO5qaWWpBxXXzJBa3Unvg4hDNpO2NCDoVgVQ46qh5jQIyUl3KvdPvfWUFPMxmw
         DUuniIQbqXUH33AlD3magRxftAuoCixtnBZB4SsFZkBtJwHCH3pJOKGGrY22sabO1gzz
         r0R0zlpAvGKBOY8z7oFyiSm3vkReQq3U7OxQEN4e+35JMIKmwzHoA9Ts3483524uzxxk
         L3o1Z+y5AXEtI0ZQeKAn9AKT8Ez/mHRpRtM5UKlZp9tokj1zqjvg06uEPSuoWeZaLV13
         mHtbnUoH+B943ee3aj+aMT86dzwpjnT6iekFOWX4rzwllfBHJ8HTkLW8/0v0f1c+Mo9M
         GoVw==
X-Received: by 10.50.72.65 with SMTP id b1mr3371553igv.63.1367031721324; Fri,
 26 Apr 2013 20:02:01 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 20:01:21 -0700 (PDT)
In-Reply-To: <CAMP44s0XnEJWjzU-g=Gq2jJQu-9MJ8S84fAd-7bdomKWEeTCtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222618>

Felipe Contreras wrote:
> That's fine, I was mostly asking Ramkumar who earlier argued earlier
> versions of this patch were not understandable.

Sorry, still catching up with list emails.  At a glance, part 1 looks
much better.  Will read through more carefully soon.

Thanks.
