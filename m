From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: qgit4 segfault
Date: Sat, 17 Feb 2007 13:22:58 +0530
Message-ID: <cc723f590702162352m7817bb21v317155f389a5c418@mail.gmail.com>
References: <cc723f590702151108u1bb8e9e8se72e9f216a23d2f@mail.gmail.com>
	 <e5bfff550702162314t36fa557dh77eca0ed1215d39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 17 08:53:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIKNX-0003sn-Mk
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 08:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946436AbXBQHxC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 02:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946481AbXBQHxB
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 02:53:01 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:52382 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946436AbXBQHxA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 02:53:00 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1787712nfa
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 23:52:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HGyPITgabWTyBcLsTTzbGcCY2aIqtYzS+pyTtIdr+b4oqjQq/qX3bQtex24KVKJOZhDsPKBaDZwrw3PPByIYhG0cDA652Xc/wscRdFkpSX5YBkmw8MAHE59aqoQPOm5++7pT6uKBPgqLOtcwOc90b+PvANN5hg/CrhKWpYvHpnA=
Received: by 10.49.8.16 with SMTP id l16mr3278011nfi.1171698778966;
        Fri, 16 Feb 2007 23:52:58 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Fri, 16 Feb 2007 23:52:58 -0800 (PST)
In-Reply-To: <e5bfff550702162314t36fa557dh77eca0ed1215d39@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39973>

On 2/17/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On 2/15/07, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> > on a linux-2.6 repo it fails during exit
> >
> > Done.
> > QProcess: Destroyed while process is still running.
> > Segmentation fault (core dumped)
>
> Patch pushed. Should be fixed now.
>

That fixed the problem

Thanks
-aneesh
