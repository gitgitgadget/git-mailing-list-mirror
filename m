From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] qgit with tabs
Date: Sat, 13 May 2006 13:31:12 +0200
Message-ID: <e5bfff550605130431w417b8aacl2b17cf5655b46f31@mail.gmail.com>
References: <e5bfff550605130344n75e3e55eq533c49fc2a4f5483@mail.gmail.com>
	 <20060513070726.qa5ssccws80go044@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 13:31:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FesL7-0007fd-EL
	for gcvg-git@gmane.org; Sat, 13 May 2006 13:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWEMLbO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 07:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWEMLbO
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 07:31:14 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:9846 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932387AbWEMLbN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 May 2006 07:31:13 -0400
Received: by nz-out-0102.google.com with SMTP id x7so322432nzc
        for <git@vger.kernel.org>; Sat, 13 May 2006 04:31:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V5I4ItG7qcM19YfdQktqmbCreXTLOJ/UTOM0Xln93ZU+3dAsLHSCgSurdksa7vwKpdbG/q5QsL+q/Dd8T8vHDjUgsfY9ABojk4gaJ0xf7pAxmDVCcVeE6D1lONqKRwf9sBYhBQRZzDFEiBvioodFIqSTLYPhJSTLu4Dyaw+NLiw=
Received: by 10.65.219.6 with SMTP id w6mr433477qbq;
        Sat, 13 May 2006 04:31:12 -0700 (PDT)
Received: by 10.64.131.11 with HTTP; Sat, 13 May 2006 04:31:12 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <20060513070726.qa5ssccws80go044@webmail.spamcop.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19932>

Hi Pavel,

>
> Just one thing for now.  Double click on a file on the "rev list" tab should
> show the patch (what Ctrl-P would do), not the whole file.  That would be more
> compatible with gitk, and it's what I normally need if I just browse the latest
> changes in the rev list.
>

Well, double click activates the current top entry in context menu.

This behaviour has not changed from past releases. To show the patch
perhaps you may, as always, double click on the selected revision, in
revisions list.

FWIK gitk does not have a file content viewer.

Thanks
Marco
