From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 11:07:38 -0700
Message-ID: <9af502e50806271107m18dfb300mfed0e2aa401cc8d9@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <alpine.DEB.1.00.0806271408290.9925@racer>
	 <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
	 <alpine.DEB.1.00.0806271844230.9925@racer>
	 <9af502e50806271049m4015b0b7nbb1c4c94a4e1a2f4@mail.gmail.com>
	 <alpine.DEB.1.00.0806271854120.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:08:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCING-0002Bq-Av
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 20:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758494AbYF0SHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 14:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762818AbYF0SHm
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 14:07:42 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:33138 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762900AbYF0SHj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 14:07:39 -0400
Received: by fk-out-0910.google.com with SMTP id 18so542639fkq.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2aAhiDTkOT29VPgmFnwbJHJkFzX+/jDQP6R7+Sscusw=;
        b=g/Co91ncAbOP81cjWHtTiS+5029gfm2St/BZBDSsYRaDPjnbNRtZHaWxM3H0Y4LB7n
         DnITTeRXlPqSjb0U/IG4kt2xS8oHax1IYe06eXv0S2hzos9vWtT+2APA7HXsERnBTM82
         Pu4XxjKqt20nyRU0yLK02sbcgTzdwvUp/o5ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vmYGiquRN+/+56oCSF1vWVIxyGE2yIMXrqT2nVnarCYySrA2+cXSJiPjemSGXbmIHw
         D2RcirLNU3Zko+shzOmvaWNmYF14QZnNoQLEDlWAaE+RtcpV4cdMSmysgjwx0sT6R+Sz
         JO79+KtAw9WDGQJmwT3a8bhAReg4BiS9ESWrw=
Received: by 10.82.107.3 with SMTP id f3mr69834buc.87.1214590058337;
        Fri, 27 Jun 2008 11:07:38 -0700 (PDT)
Received: by 10.82.178.10 with HTTP; Fri, 27 Jun 2008 11:07:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806271854120.9925@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86615>

On Fri, Jun 27, 2008 at 10:54 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 27 Jun 2008, Robert Anderson wrote:
>
>> Here's a patch to match the local culture:  "It is incredible how stupid
>> the idea of the index is."
>>
>> Clearly you should now be interested.
>
> No, you're wrong.  I am totall uninterested in talking to you now.
>

Tongue in cheek, of course - a play on Linus' "narrow minded views"
about svn.  Not much of a sense of humor, eh?

You may consider the idea that the next committed state ought to be
available for build/test to be a "narrow-minded" view.  I find it to
be a manifestly sound view.  In fact, if you disagree I have little
respect for your technical judgment and therefore am not concerned if
you will not talk with me.  Which is too bad on both counts.

Thanks,
Bob
