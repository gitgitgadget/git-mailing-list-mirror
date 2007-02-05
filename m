From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit on Mac OS X
Date: Mon, 5 Feb 2007 18:39:41 +0100
Message-ID: <e5bfff550702050939n300ffe33gcd08d927e5d68c6f@mail.gmail.com>
References: <loom.20070205T130544-216@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pazu <pazu@pazu.com.br>
X-From: git-owner@vger.kernel.org Mon Feb 05 18:39:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE7oh-0005nn-HT
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 18:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbXBERjo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 12:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbXBERjo
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 12:39:44 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:17610 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbXBERjn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 12:39:43 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1667924nze
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 09:39:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fkoWVancxwN/8f7JJ3KnUCYskkTiLsjbKYBYohcHpIR9rYWf5wAmE5NSX3ZTxtpsMnlbiEJjMc/TMfmY+XpxZtM6QMpcUy5e1IrWIANDnkF7qE/P1woNSndrV2QBGw/3+cfpPQ+O6gOhs5Z1Vfqi3BysdGwT8Q42gdNRpcoPCdU=
Received: by 10.114.157.1 with SMTP id f1mr635484wae.1170697181624;
        Mon, 05 Feb 2007 09:39:41 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Mon, 5 Feb 2007 09:39:41 -0800 (PST)
In-Reply-To: <loom.20070205T130544-216@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38760>

On 2/5/07, Pazu <pazu@pazu.com.br> wrote:
> Has anyone tried to compile and use qgit on Mac OS X?
>
> This week I installed qt-mac (3.3.7), and tried to compile qgit. Everything went
> surprisingly well, and compilation finished without any errors. Now I'm able to
> launch qgit, but the main window seems unable to receive focus, so I can't
> interact with the application. Here's an screenshot:
>
> http://pazu.com.br/dav/qgit-osx.jpg
>
> So, I'd love to hear if anyone else tried to use qgit on OS X, and if you had
> better luck than me.
>

Sorry, I cannot help you because I don't have a MAC.

An idea could be to try to use the Qt4 version of qgit, still some
rough edge here and there but it seems to work, both on Linux and on
Windows.

Public repo is:  git://repo.or.cz/qgit4.git

Good luck ;-)

Marco
