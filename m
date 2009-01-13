From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: [PATCH,v2] contrib/examples/README: give an explanation of the status of these files
Date: Tue, 13 Jan 2009 10:01:58 +0000
Message-ID: <18071eea0901130201r41c576e6t7f8c9fda7259e9f2@mail.gmail.com>
References: <7viqokf21j.fsf@gitster.siamese.dyndns.org>
	 <877i50ovdd.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Jan 13 11:03:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMg7J-0001YI-Pn
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 11:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbZAMKCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 05:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbZAMKCA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 05:02:00 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:50306 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbZAMKB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 05:01:59 -0500
Received: by wf-out-1314.google.com with SMTP id 27so11962420wfd.4
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 02:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9mg19Di1zfvRvSmNZwza2mc2OLZKIBEuXfDELhLIch8=;
        b=k8WW8xx4KtAUVOqilqsUOsRuIyhATZHIcFrdAeLiC/aHlHouOw5yWpr9esrS4CwvWw
         Xw+62AMd5wEBLv55OJB9FESkHsqZsQfHEU83AIOtsSnmyfY+gVjGLMqWxrOKQjElAx0c
         PnnUqb/01KiypBDtoSU7/zpqddUZ6HiwmLDpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PXohBVAtMcaAqehbnG+317ylLyrEqb6Hv1ust213SqzZ/izfe2dLYhljgHHDuDur9b
         ifhn9t/Cg9Q3SkddiUxEH+gEfxssIZ5eeEFDBInbHtbBmK8b/ufwiEyxbxMBza43xNZ2
         zchQqJV+hZUgw7sqADK+7ydU77wnGlUTAGoDw=
Received: by 10.142.241.10 with SMTP id o10mr12804574wfh.268.1231840918735;
        Tue, 13 Jan 2009 02:01:58 -0800 (PST)
Received: by 10.142.253.15 with HTTP; Tue, 13 Jan 2009 02:01:58 -0800 (PST)
In-Reply-To: <877i50ovdd.fsf_-_@jidanni.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105482>

2009/1/13  <jidanni@jidanni.org>:
> @@ -0,0 +1,3 @@
> +These are original scripted implementations, kept primarily for their
> +reference value to any aspiring plumbing users who want to learn how
> +pieces can be fit together.

"... who want to learn how the pieces fit together" is the correct
phrasing.  The above is incorrect.

-- Thomas Adam
