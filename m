From: Lars Jarnbo Pedersen <lars.jarnbo.pedersen@gmail.com>
Subject: Re: No common commits question
Date: Sat, 14 Jun 2008 12:09:08 +0200
Organization: Home
Message-ID: <1213438148.9800.17.camel@neo>
References: <1213435065.9800.13.camel@neo>
	 <20080614092923.GB22538@sigill.intra.peff.net>
Reply-To: Lars.Jarnbo.Pedersen@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 14 12:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Si8-0002Gy-5A
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 12:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbYFNKJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 06:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbYFNKJP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 06:09:15 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:55099 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbYFNKJO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 06:09:14 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2708656ywe.1
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding:from;
        bh=cUyyT6DXcimZLiIl1REXWd8iV0F2JMLPpou9qOUbrrw=;
        b=UdTbEfe4quQpGokZTFppKU7CyqFNrSMmBi+UOYqDerL/C4zLEZgphoVgzHlQ4bFSrT
         ZI/aIy7BsUwMZhtUK19/xnBAFM8slswXRI+0lIb8t0uyA8ZcFiAeJgGJrEKSUBsejP6B
         As6z9NispiyHpmrJNAs6SZjSYFL49/FPCc2lY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding:from;
        b=pxrQ7acnPLDfC3YHWin3g05CWnRRITd29YcT9jFOiolJ38xPQnCJqGGx1VB0VXY7t3
         /LVsIWGqCuvK00BA6WHFDNtZcfzn/jeoIlKR+Qp/SZgvRv7ykJnAQA68VX9+/GzI2lsW
         D1GcxsjpS0A9k8lLJW3hX2iGJeU/Z3JIiu/cY=
Received: by 10.150.92.12 with SMTP id p12mr6319690ybb.236.1213438153266;
        Sat, 14 Jun 2008 03:09:13 -0700 (PDT)
Received: from ?192.168.1.137? ( [217.157.186.14])
        by mx.google.com with ESMTPS id s35sm10089909qbs.13.2008.06.14.03.09.10
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 03:09:11 -0700 (PDT)
In-Reply-To: <20080614092923.GB22538@sigill.intra.peff.net>
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85007>

On Sat, 2008-06-14 at 05:29 -0400, Jeff King wrote:
> On Sat, Jun 14, 2008 at 11:17:45AM +0200, Lars Jarnbo Pedersen wrote:
> 
> > I have been tracking the Linux kernel with for at least a year now doing
> > frequent pulls (once every other day or so). I'm not doing any
> > development so it should be a clean update everytime. However once in a
> > while I get a "no common commit" warning and git starts to download the
> > entire repo again. (It happened again today - therefore this mail)
> > [...]
> > - git version 1.5.4.3
> 
> This has been noted a few times on the list (try searching for "no
> common commits"), and there were some patches a few months ago that made
> it into 1.5.5.
> 
> Can you try with the latest stable release, 1.5.5.4?
I have not build and installed the latest stable release and use that
instead of what is included in Ubuntu. However I did let the download
complete so I cannot re-test this error (sorry). But thanks for your
quick response.

- Lars
