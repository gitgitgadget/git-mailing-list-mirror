From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the 
	SVN
Date: Sat, 28 Mar 2009 11:02:07 -0700
Message-ID: <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com>
References: <22756729.post@talk.nabble.com> <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com> 
	<1238258794470-2549665.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: jamespetts <jamespetts@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 19:04:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lncsw-0002Ty-VK
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 19:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbZC1SCZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbZC1SCZ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 14:02:25 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:49854 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbZC1SCY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 14:02:24 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1889314wff.4
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s7rRc70g46PZl0VT3LlIDwEd/JNsA6PkcOIZ1ZAzIiY=;
        b=OmjG3rOYdWqsiLM9LsfdEmhVAnjAnIiYajPqCGe/2QVdNVi6SBzxiY+MtyXhUgwMLf
         98bCmVbJO49ltKNntJRPqOtISIfqhIeelItgMaBtAoaKQSpvpL+7ppEvkxsrYDwtczVF
         WIsVvlVNIQAmVhcw1a4d3c16f6pwYDSO0kxWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dkL0+HQQLamgybS+Z8hcNkZ6H/1kOT4G9NkV/GuuEKsdNpNvAA0sTocRfpEYWykf5h
         xYIOl7/ETiosTx2dqxN3yfFcjfxWqjis9DH41KeFETSwFZN4m6uuFSbVtaIdCFvLPRHf
         6TIY750r0ijqy/nsyU0qVk3K8FWMRvGf+LcMg=
In-Reply-To: <1238258794470-2549665.post@n2.nabble.com>
Received: by 10.142.171.3 with SMTP id t3mr1410415wfe.195.1238263342215; Sat, 
	28 Mar 2009 11:02:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GitHub "Import a Subversion Repository" page does mention that you
should try to avoid "svn://example.com/project/svn" style URLs (which
SimuTrans uses).  Maybe it's having trouble with needing a username &
empty password?

Unfortunately, I've never actually used the "Import from SVN" on
GitHub.  I see you've already posted to http://support.github.com/
about this.  Have you tried asking in the GitHub IRC channel?

On Sat, Mar 28, 2009 at 09:46, jamespetts <jamespetts@yahoo.com> wrote:
>
>
>
> I just tried cloning this repo using the command below, and it appear=
s
> to be working just fine. (Hasn't finished, yet. =C2=A0Up to rev 465.)=
 =C2=A0What
> is the full command you're using when it will hang?
>
> I was not using the command line - I was using the GUI on the Github =
website.
> --
> View this message in context: http://n2.nabble.com/Fork-of-abandoned-=
SVN-mirror---how-to-keep-up-to-date-with-the-SVN-tp2548952p2549665.html
> Sent from the git mailing list archive at Nabble.com.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
