From: Frank Li <lznuaa@gmail.com>
Subject: Re: Will tortoisesvn conflict with tortoisegit?
Date: Thu, 1 Apr 2010 14:52:00 +0800
Message-ID: <o2u1976ea661003312352q15077derf176d0731290165d@mail.gmail.com>
References: <28104898.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: fantasy1215 <albertkong1984@163.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 08:59:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxENf-0003wb-Jw
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 08:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935Ab0DAG7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 02:59:50 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54154 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab0DAG7t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 02:59:49 -0400
Received: by gyg13 with SMTP id 13so295985gyg.19
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 23:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mir/pSAtn+IsaRHpkloIuf6hcJmT7G70tfacsGZiSZU=;
        b=YbfOumzmZUdItjTexHNHxwPmNVoN2uIHTTyUGlCaBmvMpb/pR/E8AlhZBrUD32wOA6
         uiejB2A4zNtzANwadpCnhFQRJmcad5wB0J2iF3/m5eVA0n5Bysz1rq/vURWb+dJeCzu4
         joh2q6IQBxrOd6IRjls58hzBqBJZwRUr8FKaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Kcrw6MzSN5wfnEdJtXkQMOu2eTI9Ht7TuF7DE/DsrOHJxBdbvhPfvCQepD5H503rxt
         My/+SMyecPWcyzrqFVJH0iINmgujIwcvDaSUa+WH2w7lgw32kAzr0ExiIfjKY7QpIJrO
         6Mz0F1194xca2OSNB1P0ADTzY2n5HWhsinUyQ=
Received: by 10.150.206.6 with HTTP; Wed, 31 Mar 2010 23:52:00 -0700 (PDT)
In-Reply-To: <28104898.post@talk.nabble.com>
Received: by 10.150.159.6 with SMTP id h6mr1036286ybe.171.1270104720118; Wed, 
	31 Mar 2010 23:52:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143720>

TortoiseSVN provides a way to share icon overlay between tortoise clien=
t.
TortoiseGit use this way.
There are not conflict between tortoisesvn and tortoisegit.

The only limitation is tortoisegit and tortoisesvn using the same icon =
set.

2010/4/1 fantasy1215 <albertkong1984@163.com>:
>
> I'm a tortoisesvn user, and I've installed tortoisesvn already!
> I'm planning to use tortoisegit under windows xp.
> But I know under windows, there's iconoverlay limit(I remember if you
> installed tortoisesvn
> and tortoiseCVS together, it may encounter IconOverlay conflict).
> So will I encounter iconoverlay conflict?
> --
> View this message in context: http://old.nabble.com/Will-tortoisesvn-=
conflict-with-tortoisegit--tp28104898p28104898.html
> Sent from the git mailing list archive at Nabble.com.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
