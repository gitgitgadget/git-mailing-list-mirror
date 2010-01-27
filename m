From: honglei junan <jhonglei@gmail.com>
Subject: Re: 3 question about how to use Git .
Date: Wed, 27 Jan 2010 16:35:53 +0800
Message-ID: <e78dc7d71001270035p4e235f18o59029b93bea25d4e@mail.gmail.com>
References: <e78dc7d71001270034k48e1a386p64e01eb8d6d1187a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 09:36:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na3Nl-000301-9L
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 09:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab0A0IgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 03:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051Ab0A0If6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 03:35:58 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:64237 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab0A0If5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 03:35:57 -0500
Received: by gxk24 with SMTP id 24so6551435gxk.1
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 00:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=Yb1N+uCvSbfFe94FkkBKgldD/0LTuLsbwvVX1XTpDd0=;
        b=wWOCsN4ISalI3o01ikqAtR+97CRnAEVeRPMaBofBiy91X9W2RJcC1kt5n0OW23Vmy2
         w9kTLN9+AK5s54sWDhfNUm/Vz+fR8d+ZTsfeAEzP9+42lNOdOU06YeFicc4J1HddraCR
         xte1/5vwtRjnsVeoK8W2wA6cULM5TTtc2oSGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=dVSXL+YKYFO4czkEqDwO0D6Fxqa4Sa4iVrPWAbyCiAgU/w8cYBkFnX+Dg5TeG9s27a
         VgDIbX9TJZs3GNA0ksQAYP/MmRVAKeCpw4fypRJsf9nEkfTdeP8rIcn/34ozE4hsUcD1
         hj+PolHiX6P++31rHVnW3LQMQSRNG3KEwgMak=
Received: by 10.101.106.16 with SMTP id i16mr11441178anm.194.1264581353621; 
	Wed, 27 Jan 2010 00:35:53 -0800 (PST)
In-Reply-To: <e78dc7d71001270034k48e1a386p64e01eb8d6d1187a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138114>

hi,i have three questions seem not not appear in GitFaq,yet confuse me much :
*) since I've already commit many patches before telling git my name
and email,should i roll back and recommit all patches to make my name
in repository?
*) i create a new branch ms_port,and then commit several patches like,
    commit 1->commit 2->commit 3->commit 4
now i just want to change commit2,without change any others,how could
i do it?since i only change the local repository,i think this should
be allowed.
*) when cloning a git repository,the network is broken down.How could
i went on the clone process when the network being OK ?
since the download speed is very low, i really don't want to remove
all things and download them again.
Many thanks.
