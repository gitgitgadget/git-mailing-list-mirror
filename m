From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] rename contrib/hooks/post-receieve-email to contrib/hooks/post-receive-email.
Date: Wed, 4 Apr 2007 13:31:26 +0100
Message-ID: <200704041331.31548.andyparkins@gmail.com>
References: <20070404115212.17022.qmail@44e948019c99c4.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 14:31:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ4eV-0005mg-B9
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 14:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966320AbXDDMbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 08:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966326AbXDDMbs
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 08:31:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20430 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966320AbXDDMbs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 08:31:48 -0400
Received: by ug-out-1314.google.com with SMTP id 44so643540uga
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 05:31:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CqjFb+BjGhAsrTFHBegyUyM9DTo/hLDGn2KneJ6YVybvhjj0V6FfYn0a1R+FuPNHgAoPCmziPw8DG2L8STXwlXx7SopFRcHppFbzpAkhdpskYGAcnJMMk3IZ5Kt2nQ1XptvfQTFlf3eI0T7mjLw7Fehy26PKk6lEsy5vVjcQh+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FuMcBhCVDZ/qrSx351C+Y+d0IhDVnmbqONdlM6T3EpGDunb925Qzr3462S/uxSxZO+lVLor36IiMNkgHabg90Cxt0TK3N5zDh6zdGUykEYcxAz2kLBV1MA3UbnA9nNaRcZbqOLbv1TOOnh36R7FenDOezUfkHffsTntIfHYdUNw=
Received: by 10.67.29.12 with SMTP id g12mr1392334ugj.1175689902104;
        Wed, 04 Apr 2007 05:31:42 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z34sm1138457ikz.2007.04.04.05.31.40;
        Wed, 04 Apr 2007 05:31:41 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <20070404115212.17022.qmail@44e948019c99c4.315fe32.mid.smarden.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43733>

On Wednesday 2007 April 04 12:52, Gerrit Pape wrote:
>  $ git grep post-receieve-email
>  $ git grep post-receive-email
>  templates/hooks--post-receive:#.
> /usr/share/doc/git-core/contrib/hooks/post-receive-email $

GAH!  How embarassing.

Does this remind anyone of being in school and writing both versions on top of 
each other because you didn't know which one was right, then hoping that the 
teacher wouldn't complain?

:-)


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
