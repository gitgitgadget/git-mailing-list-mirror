From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Sun, 14 Oct 2007 20:06:57 +0200
Message-ID: <e5bfff550710141106o5fd065c5yb8a3b627a06aab42@mail.gmail.com>
References: <1192293466.17584.95.camel@homebase.localnet>
	 <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet>
	 <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>, "Eli Zaretskii" <eliz@gnu.org>,
	"Make Windows" <make-w32@gnu.org>
To: "Benoit SIGOURE" <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sun Oct 14 20:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih7rp-0000OF-RC
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 20:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757875AbXJNSG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 14:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758179AbXJNSG6
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 14:06:58 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:49135 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006AbXJNSG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 14:06:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1241329rvb
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=o39kYTfOma04/fAUsdkF2hDxLONf7KqGEcAXKzaLk4s=;
        b=jdBPoNZFb8TtKjXzAjFsxa6yTinGBuCMDROEAaBGXVv0W23SGF0cyXSdIFaEq9ncsnukJfYO9AIw+W0bgVSPIMjMHn1G6uP9RQzTk6AzGr47YHepBiccdC/Gw/VTjsROdLOUmnSDQ2/LKf3g4XqS2iiqHwAx8ifAlwbj3rDnwpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bTm+yUK7MoNzPKVy4FGOULST5c8yCCj6Dgz0a3hPLTI7DR5zWRQssbWaSgozqct4qZPcjpIx3lQltDkAePq/2Bv1/Fqc8DzTjAtFHgx4DQIqVlDeLd/JVT0NEtgQpjGc4wonVg33bNdJ7a9cqS1ZdpldaasfyNasOegD96END4Q=
Received: by 10.141.159.13 with SMTP id l13mr2362220rvo.1192385217533;
        Sun, 14 Oct 2007 11:06:57 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sun, 14 Oct 2007 11:06:57 -0700 (PDT)
In-Reply-To: <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60886>

On 10/14/07, Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
>
> Is it possible to use one of
> the various GUIs (git-gui, gitk, qgit) on Windows without requiring a
> POSIXish shell etc.?
>

qgit-2.0 works natively under Windows

http://sourceforge.net/project/showfiles.php?group_id=139897

Check the README for how to install.


Marco
