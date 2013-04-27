From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: add missiong format-patch options
Date: Sat, 27 Apr 2013 15:20:55 -0500
Message-ID: <CAMP44s2btC+y4Mmg_UgY1WU6NHGzNS-pQ2yagXBXtu35ukXtog@mail.gmail.com>
References: <1367093864-9362-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:21:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBcD-0000O0-9b
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab3D0UU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:20:57 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:37433 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab3D0UU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:20:56 -0400
Received: by mail-la0-f48.google.com with SMTP id eo20so4470384lab.35
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=UY8LMnDMchS58uBCd9eVY4GobIrN0FOpp1W6rQAu4WE=;
        b=m0bhcnb0hoC0QenS++uhkyoclmecxEW1au92VX8X6Sj9Izo6Ruq3hZm+ObuWd0veZ+
         FvO4F/el7grbQS8exuA47hm0EdkEUeC6oyEjHwCYx+/HcIKjW9OQB1eyD/YSBjf0SK34
         32JVQEaZzzg2REpbJxdaXZsLvsn3QYxN2itjUMgk5zxcmc+fL/TZh7kJrDS6c77b75FB
         J+QiE+kadGdD8xQHx8VW2w0vFXyTL9QHSb6xnwrkWsnBW6htt9LIO1vqhHgeNpAtc2Bq
         J4du9w6uIVqW20uA5e7mSrOD7k0JdZpTh+kp15P5Ge7tMwdHU1hJ5HJhdrEwTAutVvhD
         qB0Q==
X-Received: by 10.112.140.100 with SMTP id rf4mr15301805lbb.82.1367094055505;
 Sat, 27 Apr 2013 13:20:55 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sat, 27 Apr 2013 13:20:55 -0700 (PDT)
In-Reply-To: <1367093864-9362-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222694>

Yeah, s/missiong/missing/

-- 
Felipe Contreras
