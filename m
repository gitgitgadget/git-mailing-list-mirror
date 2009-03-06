From: Tariq Hassanen <tariq.hassanen@gmail.com>
Subject: Using Git with windows
Date: Fri, 6 Mar 2009 18:23:45 +1100
Message-ID: <e878dbad0903052323m56f3d63fi69862e9dae278c00@mail.gmail.com>
References: <e878dbad0903052321l6c0d310bk2ba568138b409d36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 08:25:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfUR6-0004B8-C3
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 08:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbZCFHXs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 02:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbZCFHXr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 02:23:47 -0500
Received: from wf-out-1314.google.com ([209.85.200.170]:30965 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbZCFHXq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 02:23:46 -0500
Received: by wf-out-1314.google.com with SMTP id 28so402921wfa.4
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 23:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=/Tjo7ghMegnM8Z1gkeA6lk7Scph5x8zTmZ9QcWOBdbM=;
        b=kdB2e31K63JiMmBR7v1ss+ktgf/63eOReVA1kXl1c6BO3oiQYMd5rs/DFtNsVXWNol
         AzjNBTfKzSo55kBMoK0qDfd2Nsw7j/J+c7VnBne/5T37QTcgU297CmbQu7v8fx36pJYb
         hfkwjT6GfFUuLUdugvLnP1zX+Hpy1j/nMYtCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=j4s/vG3Gp7nLu1qInQuOdS3Vsi8Nq47ArA9sw6bVqTutzkX/8g1eDQ4TqMfJdfbWbl
         9PfTd7JrLKnAqsvsfpuPYjqpyefStiukns7Se+BWxvoYrLGvIoZM5yHrBUfAWK1e6kEZ
         Ei2YgioikUpWtaN0AvgjKy/s5Ee7JLCpshccc=
Received: by 10.143.3.16 with SMTP id f16mr950515wfi.344.1236324225081; Thu, 
	05 Mar 2009 23:23:45 -0800 (PST)
In-Reply-To: <e878dbad0903052321l6c0d310bk2ba568138b409d36@mail.gmail.com>
X-Google-Sender-Auth: 389fece576cec3f2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112396>

Hi all,

I know there are some ports for it on windows such as=A0msysGit and it
can also be done on Cygwin.
But is there a way around this if i run a linux VM with Git running
and mount a windows ntfs partition ?

Im trying to keep the power of Git running on linux and the ability to
use Git for .NET apps
Any ideas? Or am i best sticking with SVN until the ports are mature en=
ough?
Tariq
