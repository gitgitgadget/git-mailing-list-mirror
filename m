From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: qgit4 and top of git tree
Date: Sun, 25 Feb 2007 22:55:58 +0530
Message-ID: <cc723f590702250925m3795ca58w7e276d2c61fa8f19@mail.gmail.com>
References: <cc723f590702240803o24ca01ffxfea904bf7b11c05@mail.gmail.com>
	 <e5bfff550702250902q11b74fecvce1ea9d79dec8f92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 25 18:26:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLN8Q-0001vb-VD
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 18:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbXBYR0B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 12:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbXBYR0A
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 12:26:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:56413 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965024AbXBYR0A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 12:26:00 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1489948nfa
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 09:25:58 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gs2Ant3AAJUn/5OlkQdA6iB2qMHPw7KMl9eD8FT29Z1eGiWCQQ1VeTYphdF3NSA11UfIHU+PqZnZbu5KG/bW2fim8BVPpZbt8kwhAklUQuLxeNbOUePMb1+OcwGn0r/pCNld200AQcyZ+xmRMa1+bwSwHAJsl5JDrK+QyWwBKYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jau1BrgXt73v0ROIt7LI5ADcGNOYgbYZwUET7ciohFSMK4/O+7UebfR9L7DyUo+GCkG3xcQaBEUfV/vtIVb6K9FoEt80XZWL+Ry+oK2Uig95nEY0V/kRvPE/BEO255V45dGxjQKMSQBHQ4D2dkkYspckCIEnbtjZMN0pclr8X+g=
Received: by 10.48.48.18 with SMTP id v18mr10821492nfv.1172424358581;
        Sun, 25 Feb 2007 09:25:58 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Sun, 25 Feb 2007 09:25:58 -0800 (PST)
In-Reply-To: <e5bfff550702250902q11b74fecvce1ea9d79dec8f92@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40557>

On 2/25/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On 2/24/07, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> > top of qgit4 and top of git. The top level commit is not displayed
> > properly.  I guess something related to commit parsing went wrong.
> >
> >
> Thanks Aneesh,
>
> patch pushed....stil not clear why it happens though.
>
>

I liked the new look. Is it possible to make the header background
color fill horizontally.

-aneesh
