From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Patches for qgit on MacOS X
Date: Fri, 4 Jul 2008 07:46:13 +1000
Message-ID: <e5bfff550807031446g54fc4f93x73636b2c49b03981@mail.gmail.com>
References: <48665027.3090406@free.fr>
	 <e5bfff550806300300s2a0c0e60sdaa86453116c531f@mail.gmail.com>
	 <4869E55C.2020608@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Olivier Croquette" <ocroquette@free.fr>
X-From: git-owner@vger.kernel.org Thu Jul 03 23:53:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEWkD-00067I-2d
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 23:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066AbYGCVqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 17:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756321AbYGCVqR
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 17:46:17 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:60725 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386AbYGCVqP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 17:46:15 -0400
Received: by yw-out-2324.google.com with SMTP id 9so430314ywe.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 14:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BEIEgmT9ScfFWv6Ul5wNjhgUiQbxytBxRedJ0olki28=;
        b=K83pLWBYapO9l+ma0+IIFFRPwOZ7dH1GJzBHT3qrbzrVF5t9aRKtpgUFdVniypfTJa
         KJK+cjs8cjjjWCUppcVPS3ufebS4UM5BWS1RjPcHkPapGdJEB5jJCgFlz8XDyNZs4uIK
         AXExd0dC4ETVYre8H3U7VIoPV8xv7TW1hDT4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=RmByVg1KgG3a4JzLlR6FRSU3MPI7HSDPVKcuDvAkz/RiJkqF20fYSnqDwoAHOFnYf5
         EYnZZyKDCrRkgNjRlSLZ+ObYLHTc0gB8Ldk0KIKZYVUk5TQjRNzzVoKRwwf3H3Sti08D
         9LIwcJpqUkeeJSwVld2xN0Rl4ph2UwZ5L9deQ=
Received: by 10.142.203.19 with SMTP id a19mr69916wfg.179.1215121573916;
        Thu, 03 Jul 2008 14:46:13 -0700 (PDT)
Received: by 10.142.231.11 with HTTP; Thu, 3 Jul 2008 14:46:13 -0700 (PDT)
In-Reply-To: <4869E55C.2020608@free.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87326>

On Tue, Jul 1, 2008 at 6:05 PM, Olivier Croquette <ocroquette@free.fr> wrote:
> Marco Costalba wrote, On 30/06/08 12:00:
>>
>> Thanks for the patches, I'll apply them.
>
> Great!
>
>> Can I ask why don't you use qgit-2.X series ?
>
> Sure you can, it is just because I overlooked the existence of the
> version 2 :)
>
> After compiling qt4-mac from source (it took quite some time), I have been
> able to compile qgit2 too without a hitch, so I guess the patch is
> irrelevant for qgit2. Are you using a different mechanism to access the
> environment?
>

Sorry for my late reply, but I'm traveling these days.

No I don't use a different mechanism I always access the environment
through the Qt libraries, so probably the improvment is in Qt4 over
Qt3.

Marco
