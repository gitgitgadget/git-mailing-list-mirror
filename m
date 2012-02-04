From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] gitweb: Faster and imrpoved project search
Date: Sat, 4 Feb 2012 21:59:00 +0100
Message-ID: <201202042159.00950.jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com> <CAMP44s2gLvXXCTTpAV78=DeJA9dSV793+bx=yJmns7vCwegagQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 21:59:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtmhQ-000290-Ma
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 21:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555Ab2BDU7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 15:59:03 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56775 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab2BDU7B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 15:59:01 -0500
Received: by eaah12 with SMTP id h12so1954073eaa.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 12:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=/7h3Fy5cWvQcCZkkvsXMgtnz0fBWvvR+8+Wz3T41CUA=;
        b=mpFwxtJCx2yi57XNnrW5KSEU7PHjSfK33hkvacSHv+vbJLDzR/Vr1wkKWkLIZ63wSA
         ubNZbhfggrLuh8v86oPGmebzaP0NHwE6dPTgnKqbYNu66xTVC5GUjX7AEgPEmztTL8/h
         yWUA8Qh9QWnOg5wlXDp/YT+v+YGZOnL6hxhmk=
Received: by 10.213.28.5 with SMTP id k5mr489361ebc.35.1328389140379;
        Sat, 04 Feb 2012 12:59:00 -0800 (PST)
Received: from [192.168.1.13] (abwp204.neoplus.adsl.tpnet.pl. [83.8.239.204])
        by mx.google.com with ESMTPS id o49sm39451504eei.0.2012.02.04.12.58.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 12:58:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CAMP44s2gLvXXCTTpAV78=DeJA9dSV793+bx=yJmns7vCwegagQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189907>

On Sat, 4 Feb 2012, Felipe Contreras wrote:
> 
> Typo: improved

Yeah, I have noticed this just as I have send it, but because it is in 
_cover letter_ rather than in commit message...

-- 
Jakub Narebski
Poland
