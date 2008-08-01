From: "David Aguilar" <davvid@gmail.com>
Subject: Re: [ANN] git cola: a highly caffeinated git gui
Date: Thu, 31 Jul 2008 23:52:18 -0700
Message-ID: <402731c90807312352raa55138y858fbb8650919265@mail.gmail.com>
References: <402731c90807312308l4870382dsb707fafd37f9b1d4@mail.gmail.com>
	 <20080801083413.2ac1782b@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, msysgit@googlegroups.com
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Aug 01 08:53:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOoVu-0007uC-Uk
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 08:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbYHAGwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 02:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbYHAGwV
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 02:52:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:50729 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbYHAGwU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 02:52:20 -0400
Received: by ug-out-1314.google.com with SMTP id h2so457584ugf.16
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 23:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mx/a90EDVLifoNVA2ZfhpqtCY1PSI3UqwAxwmBjpCs0=;
        b=SUHA/dcT6H+uA5Hhuc8Ni84ICCc8/D7iN21SLH0faCc002Y3ttIItPe4OWSqv6lg/0
         bDJe1dIDxmLW6w2LvcacI8M66wJ6dVlCoiayY/dShpYNTs9I4GLrvWtosZ09nuDzqejU
         XhOp5iNAsq5PPoXU3tihtdbX4sbqOrBWPQbis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=D8Og9ETGm1uUHsO+YuDln9SFpDcRK9i3Q0moTEoCu878Ikdn7LrTjN8MvSZE5bvwuY
         flyznnbBXJNDAp/p3hUrGrGK1HqaBwXJO+msDtDR0mXwM/uHos75ENBWVuUlr86KjqLV
         NSUWuMBd1NwNatqiAyqLPh6wQlF0armBhLoH8=
Received: by 10.67.26.7 with SMTP id d7mr3379098ugj.44.1217573539155;
        Thu, 31 Jul 2008 23:52:19 -0700 (PDT)
Received: by 10.66.241.12 with HTTP; Thu, 31 Jul 2008 23:52:18 -0700 (PDT)
In-Reply-To: <20080801083413.2ac1782b@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91031>

On Thu, Jul 31, 2008 at 11:34 PM, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> On Thu, 31 Jul 2008 23:08:01 -0700, "David Aguilar" <davvid@gmail.com>
> wrote:
>
>> Greetings!
>>
>> The latest version of git cola is available for download from the
>> usual interwebs:
>>
>>     http://cola.tuxfamily.org/
>>     http://gitorious.org/projects/git-cola/
>
> Your dependencies don't match.
>
> # cola-1.1.1-2.noarch.rpm

sorry, I used alien to convert my .debs into an rpm. scripts/mkdeb.sh.
yum installing pyqt4 should fix it.



> ImportError: No module named PyQt4.QtCore
>
> --
> H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
> using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
> 11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
> http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
> http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
>



--
 David
