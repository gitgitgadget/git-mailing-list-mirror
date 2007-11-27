From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Tue, 27 Nov 2007 14:15:21 +0100
Message-ID: <e5bfff550711270515t2a7bc80ege92442c30bf6aebe@mail.gmail.com>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org>
	 <e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com>
	 <figlf6$d48$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 14:15:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix0Hu-0000xm-Jw
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 14:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbXK0NPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 08:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbXK0NPX
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 08:15:23 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:50192 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbXK0NPW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 08:15:22 -0500
Received: by rv-out-0910.google.com with SMTP id k20so877069rvb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 05:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2+K/z0mo3JgFMpo1N4XwuuS2TR1iBYsKDA846BNyio4=;
        b=pynbai8NkIniSUU431euqsfpYlsJ70fPxlRDKNHo+uI077Av/fDvcqCZYRpLNt2uvLUbsd0ed2SEA1j2/qH6qOnB2xeSiDhi7e5JpU7hn0m/nSlwHrDYVdE6dqFQEjLUNqzBQuMCRXzvpjH+g3Ir43RnbdMJFJJc3uw2q4/m+FI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UmK3V/2lh7mNf7pFetnylFkJJdzF6Dt4z1DKXeWY5Ob1CVG2OYHcKbXx6TZexd0nCz42dtS0jqZ69p3rHQrj6duij0oX4RJ77th8F6vBpyKwcv+wDz+PGAs1ZzEC5CR/WorMP7ZanQvqMK5MjfnJs/+spSfDt2Qa8/kd6BnlVAw=
Received: by 10.140.164.1 with SMTP id m1mr1859723rve.1196169321788;
        Tue, 27 Nov 2007 05:15:21 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 27 Nov 2007 05:15:21 -0800 (PST)
In-Reply-To: <figlf6$d48$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66205>

On Nov 27, 2007 9:45 AM, Andy Parkins <andyparkins@gmail.com> wrote:
> Marco Costalba wrote:
>
> > But...wait...Qt would require...(I'm scared to say!)... that awful,
> > painful, hopeless thing called C++. Probably you didn't mean what you
> > said ;-)
>
> Actually although I like C++, that's not the reason, the reason is that Qt
> is a significantly (IMHO) better toolkit than Tk.  It's more cross platform
> and looks a lot nicer.  The fact that it's C++ is neither here nor there.
>

Actually there exist a Python bindings for Qt if you prefer.

I was just joking about C++, never meant to start a "language war"
that I personally consider as very very un-useful and very pity.


Marco
