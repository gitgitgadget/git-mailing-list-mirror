From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] git-gui USer's Survey 2007 (was: If you would write git from scratch now, what would you change?)
Date: Sat, 1 Dec 2007 03:53:26 +0100
Message-ID: <e5bfff550711301853w3fe4a535q85ae7f90b964e296@mail.gmail.com>
References: <fifstd$ilj$1@ger.gmane.org>
	 <Pine.LNX.4.64.0711271136050.27959@racer.site>
	 <fiib19$dj6$1@ger.gmane.org>
	 <Pine.LNX.4.64.0711281225150.27959@racer.site>
	 <20071128232523.GE9174@efreet.light.src>
	 <Pine.LNX.4.64.0711282345500.27959@racer.site>
	 <20071129065706.GA24070@efreet.light.src>
	 <Pine.LNX.4.64.0711291200000.27959@racer.site>
	 <20071130175018.GB30048@efreet.light.src>
	 <20071201023520.GQ14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jan Hudec" <bulb@ucw.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 01 03:53:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIUQ-0007Iq-I3
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758860AbXLACx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758755AbXLACx2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:53:28 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:20468 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758792AbXLACx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:53:27 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2141777rvb
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 18:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HTFp9HRety/52I4e5fGhmT4Yc/dYSeZ3vJAmTRcaz/8=;
        b=Enotch+6rYlI+2PyVm4smBrMtYaMOB6HhTmhY+RMYJAfZQz9npwk4lJpIVNzWaUbUg8+wZr2UD+cxSzr0fDNGuRzgU4axGe9HHgEJIUqsdywqF5Vz4+y8qw72Pjz5Bq2Bo2bTnrWq4LHBpLZa+8Ylc5PgTVCfWLAvng04kplHUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y9/mKmeeSYn3YiR9FyYwLgR6CF/4Ygf7vYSeR9OAvDL0lluaXGkEDhz1wfgfhB/mICoVkpmg0A9itNeyLkV1u6dr//GrrNgmJoROq51eqgCnnwAxIp1VVu+ND6uyCHlKL8ZssePeshSEK6JLlbM4xdC+aRWXQYwbkYttjZOEOsI=
Received: by 10.140.199.19 with SMTP id w19mr4417812rvf.1196477607033;
        Fri, 30 Nov 2007 18:53:27 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 30 Nov 2007 18:53:26 -0800 (PST)
In-Reply-To: <20071201023520.GQ14735@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66691>

On Dec 1, 2007 3:35 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
>
> Building context sensitive menus isn't fun.  Managing some data
> structures in Tcl isn't fun.  The list of why I'm currently unhappy
> with Tcl/Tk for git-gui is actually pretty long.
>

Not to advertise, just my two cents, but Qt with whatever language
binding you want to use, it's really powerful, easy to learn,
documentation is great, easy to create GUI forms, actually you don't
even need to program because Qt Designer let you create a form
graphically, the result is a XML like file that a Qt tool called UIC
transforms in a compilable file.

Qt library is consistent and complete and very portable, especially
Qt4 works and installs under different OS with no hassles. And the Qt
community (http://www.qtcentre.org/forum/) is very helpful and
supportive.

I really don't want to advertise, but after reading your list of
Tcl/Tk cons I was not able to stay quiet.

Marco
