From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] CGIT 0.9.0.1
Date: Mon, 13 Jun 2011 16:42:59 +0200
Message-ID: <BANLkTi=xo89_KX3rdpn8ovwrwkKP=O-gQA@mail.gmail.com>
References: <20110613124954.GA737@hjemli.net>
	<20110613134919.GJ14016@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: cgit@hjemli.net, git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 16:43:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW8M6-00064t-Em
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 16:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503Ab1FMOnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 10:43:00 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:63618 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab1FMOnA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 10:43:00 -0400
Received: by pxi2 with SMTP id 2so2991555pxi.10
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oy3Px4Pn4D8BSxP/MlQu72bP6a9MLxTtXU9RUNRhQoQ=;
        b=byu1g4OPhZSluucaOQZFnpvzVokjQDhRDsFMl8EzWzWhM4cOZgjZv3hUJ3wh59/KDO
         FIyFcV0SgNw3q7seOd+Kf7hYFjbu8l9MKJz4fypDxn+sUBQXX31TRerMkRXLUZhOk+P3
         oTVpu+vPVhDXPcVquVe7ME85CFhAsKO3NRM0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pg8cjN/F4wbI42T8KEwSt2Blb8hCNgKl6lKNxiBRA5JrxkaalwGgXKedzEFyaWCX7/
         dXX9KktaFGeboCoU/GVvL8VAiLsnU5WdSZQ6M3pj3N4YRB8cFcSs2WtsOd/q5TauV92O
         twCLK31xMNf7IMpAmcMy2X89F5Tm6WdjoEFHQ=
Received: by 10.142.67.40 with SMTP id p40mr584877wfa.218.1307976179166; Mon,
 13 Jun 2011 07:42:59 -0700 (PDT)
Received: by 10.143.76.8 with HTTP; Mon, 13 Jun 2011 07:42:59 -0700 (PDT)
In-Reply-To: <20110613134919.GJ14016@inocybe.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175709>

On Mon, Jun 13, 2011 at 15:49, Todd Zullinger <tmz@pobox.com> wrote:
> larsh@hjemli.net wrote:
>> A bugfix release of cgit (a web interface to git repositories) is now
>> available from http://hjemli.net/git/cgit.
>
> Did the v0.9.0.1 not get pushed yet?

I forgot to push the tag, thanks for noticing.

--
larsh
