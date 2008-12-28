From: "Dilip M" <dilipm79@gmail.com>
Subject: Re: user manual question
Date: Sun, 28 Dec 2008 22:06:56 +0530
Message-ID: <c94f8e120812280836j4acab974s5139167ac6be54ee@mail.gmail.com>
References: <gj7mmo$fvk$4@ger.gmane.org>
	 <slrnglf3qh.c7j.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sitaram Chamarty" <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 17:38:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGyev-0003K7-4u
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 17:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbYL1Qg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 11:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbYL1Qg6
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 11:36:58 -0500
Received: from mail-gx0-f13.google.com ([209.85.217.13]:54353 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYL1Qg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 11:36:57 -0500
Received: by gxk6 with SMTP id 6so3584538gxk.13
        for <git@vger.kernel.org>; Sun, 28 Dec 2008 08:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ImKUneNh0zewnqNdwIk5iNVXTVdTgyWU/2caozKrjfo=;
        b=W1IUeyE6EnEj3jkyWE7pk1ofhATynHTk1TBRrAw/gtcSNV2GmYwCdfuxkYrT0Ff5O/
         5kqfiRUpPCtfEl/1ikDvbZQWxRMYDGqxj2loH2pIeYWVL5CQdEF23Pre8AcITD0YWFvA
         leQBKBDAO+3my/OZZJ58x1OtIK/fjAZmujBfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gh/g0BBznP2iMq8MITU2o0bLKHFXIxP2E+poFT7C20kiMJ4vgiQR1+qNMXvjw+0IsS
         F8ifnhoi0O1MXGYogmu1e88fC6cpTVqTfg3OcXg3a1fEmqcnSI4CFrJxar2udaxKplUr
         hGddTFqrwRNzNA7D5lUoM+HgmPH9h63Q6yIrg=
Received: by 10.100.228.13 with SMTP id a13mr7243245anh.110.1230482216514;
        Sun, 28 Dec 2008 08:36:56 -0800 (PST)
Received: by 10.100.142.5 with HTTP; Sun, 28 Dec 2008 08:36:56 -0800 (PST)
In-Reply-To: <slrnglf3qh.c7j.sitaramc@sitaramc.homelinux.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104052>

On Sun, Dec 28, 2008 at 8:08 PM, <sitaramc@gmail.com> wrote:
> On 2008-12-28, Zorba <cr@altmore.co.uk> wrote:
>> Under "Examining an old version without creating a new branch"
>> subsection in chapter1
>>
>> to aid my understanding, could the statement:
>>
>> "The HEAD then refers to the SHA1 of the commit instead of to a
>> branch, and git branch shows that you are no longer on a branch:"
>>
>> be restated more explicitly as:
>>
>> "The HEAD then refers to the SHA1 of the commit instead of to a
>> branch head, and git branch shows that you are no longer on a branch
>> head:"
>
> Sure, but I prefer "tip"; reduces confusion between "head" and "HEAD"
> in spoken descriptions (I teach internal classes on git occasionally,
> once even on a conf call!)

+1

I was (am) was initially confused about head and HEAD and assumed that
they are both same.

-- dm
