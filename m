From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: default aliases (ci, di, st, co)
Date: Thu, 9 Jul 2009 11:40:15 +0200
Message-ID: <200907091140.16651.jnareb@gmail.com>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com> <4A55958E.1050401@op5.se> <4A55AF45.4040700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Ondrej Certik <ondrej@certik.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 11:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOq7B-0002by-HB
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 11:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbZGIJkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 05:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbZGIJkX
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 05:40:23 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:55039 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbZGIJkW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 05:40:22 -0400
Received: by ewy26 with SMTP id 26so34786ewy.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yFf3dqHg8EwcdViDw+wYQEiQdXpznARuQnUGVjbqKL4=;
        b=ooSJwSOFRQ4m00/k+ea6hJu5v6dHk7tMtF9ZdktEfNGFUKh6w/3QyjBaS5OBXprYx4
         0ko28MCCGfXrCUI/2lb64cxyZpRYAqgcY11oREM3pAf/rBxU3aKo/Xg8fYju5iCNJzbS
         Pt50XzCTge7XEdrWw9ub61PaHhelKkub0ndIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hK8eDc1z7BUbvEp6iMLD5dezWDKMbXas2xGJazBrUPc9a9Gwf9o0iA7Ga7hByWzrzQ
         raCsRMkSohU0bvO4rRRVC/3wPkBh/KT8jDiP3pOL9UmeXIr+vZyCqxIVcF2PfOimYCz7
         Rce7w1tXzxYsyOOavs2HmZGuMCnkP5XQ8C6zs=
Received: by 10.210.132.3 with SMTP id f3mr698455ebd.41.1247132420341;
        Thu, 09 Jul 2009 02:40:20 -0700 (PDT)
Received: from ?192.168.1.13? (abvk53.neoplus.adsl.tpnet.pl [83.8.208.53])
        by mx.google.com with ESMTPS id 5sm2197321eyf.44.2009.07.09.02.40.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 02:40:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4A55AF45.4040700@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122963>

On Thu, 9 July 2009, Michael J Gruber wrote:

[...]
> Aliases are great, but default aliases are a problem. We saw this when
> we introduced "git stage", and I don't think we're happy in
> retrorespect. 
> 
> Having said that, collecting useful aliases (e.g. one, who, ...) in
> contrib/ or in the wiki would be helpful.

http://git.or.cz/gitwiki/Aliases

-- 
Jakub Narebski
Poland
