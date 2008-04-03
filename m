From: "James Kingston" <james.kingston@gmail.com>
Subject: Re: newbie with broken workflow
Date: Thu, 3 Apr 2008 18:41:33 -0500
Message-ID: <9d27c6320804031641s2a1578fcmd7271a06842803fe@mail.gmail.com>
References: <9d27c6320804031445p3fc80115n59218673dd587795@mail.gmail.com>
	 <8aa486160804031503j1ff3adbcu83f41eef14347370@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 01:42:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhZ4V-0004Nj-IP
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 01:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbYDCXlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2008 19:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbYDCXlh
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 19:41:37 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:47080 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbYDCXlg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2008 19:41:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3829626wah.23
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 16:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ldRX/6vfM81prH+dwpFLSTxsX81d8x7wpI+JOUbpWiw=;
        b=JvhHdqZtlj52sG+qEI7fTXST3N+eDcf9emMH7DMeZeKT7vbzoYRGoxdODSdsEcvR1REnIZvkh/GX20NQBIGbcQhr9oA7+5SkDk5ZrVq3n6wLEmp1OiXz1qM8tXeZi1gfzW98hXI0zdhT/zM6fyh9KzhXqoQMC+rv3jeDo3NuOjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n30DyYPLnoy9cWRBYsrcvso3R5gNP9MO6n4giHDQKEfUqjKNKUpaDpuHD2wQqQDUElcrCp1ErN3DDWPmY+QpjXOTQ5ikiqOtrMFKfzYfZ2GHN9zW0Acn42P4Dz8hgadjCDwpQZdjliUh5ZV9m9Q3aV29Bu1RGZ5alWGpo0K+3mM=
Received: by 10.114.106.1 with SMTP id e1mr846599wac.71.1207266093995;
        Thu, 03 Apr 2008 16:41:33 -0700 (PDT)
Received: by 10.114.57.6 with HTTP; Thu, 3 Apr 2008 16:41:33 -0700 (PDT)
In-Reply-To: <8aa486160804031503j1ff3adbcu83f41eef14347370@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78787>

On Thu, Apr 3, 2008 at 5:03 PM, Santi B=E9jar <sbejar@gmail.com> wrote:
>  git push updates the branches, not the working copy, so:
>
>  cd /c/cc
>  git pull /c/wd/cc HEAD
>  Santi
>

Thank you.  I also found the FAQ in the wiki, so the reasons are clear.
