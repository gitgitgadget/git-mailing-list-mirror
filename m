From: "=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?=" 
	<pclouds@gmail.com>
Subject: Re: Git Survey summary
Date: Thu, 21 Sep 2006 21:12:18 +0700
Message-ID: <fcaeb9bf0609210712i125822c4gf8af3ecccdbd3d13@mail.gmail.com>
References: <fcaeb9bf0609120205m38a44571we21e05864c04a731@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 21 16:14:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQPHr-00054D-Kd
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 16:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWIUOMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 10:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWIUOMU
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 10:12:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:13623 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750762AbWIUOMT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 10:12:19 -0400
Received: by wx-out-0506.google.com with SMTP id s14so680348wxc
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 07:12:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SCxPsQDNlLxIaKY0qGNc0FS8lLwNNByQBJkGcMdZchE9wHFqEfNEZyktwbaqmFaqY9yUhBSg24FhTF8hJ3L00M4dbzaFCOlmSVgoFUz5oEnegGj/23QgJ6s/auNDH3kU5ZwpD/s4T48zLLbqRfuk3tK5AU/C/WobV3MfTcieC9o=
Received: by 10.70.29.7 with SMTP id c7mr5704222wxc;
        Thu, 21 Sep 2006 07:12:18 -0700 (PDT)
Received: by 10.70.45.19 with HTTP; Thu, 21 Sep 2006 07:12:17 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <fcaeb9bf0609120205m38a44571we21e05864c04a731@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27477>

FYI, I've completed the survey summary (except Q13, repo size, which I
don't know how to handle it. And there was no Q14 in GitSurveyData).
You may be interested in Q20 and Q31.
Some thought after completing this summary:
 - Documentation is still most wanted (as a comprehensive book or
examples/use-cases). There were many answers indicated that users
didn't know about existing git features. We should advertise git
features more.
 - Git homepage and Git wiki (and sometimes git mailing list) are
unknown to many users. Perhaps we should put them in git.7 man page?
 - Plumbings/Porcelains confustion. Is it about time to move all git-*
into /usr/lib/git? Also some probably wants to integrate cogito into
git.
 - A place to post bugs and feature requests (if bugzilla is too big,
maybe mantis?)
 - (This comment is mine) Git should ship NEWS file in release
tarballs. An auto generated ChangeLog in tarballs is also great (maybe
make git-changelog to generate the changelog)
-- 
Duy
