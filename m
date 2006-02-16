From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git faq : draft and rfc
Date: Thu, 16 Feb 2006 17:04:10 +1300
Message-ID: <46a038f90602152004i30c67a56i24dd9dfd41c0e873@mail.gmail.com>
References: <22e91bb0602151636r2e70e60cpa5038f4b6caccc9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 05:04:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9aNP-0004un-LB
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 05:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWBPEEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 23:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWBPEEQ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 23:04:16 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:12357 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932134AbWBPEEQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 23:04:16 -0500
Received: by wproxy.gmail.com with SMTP id 68so88079wri
        for <git@vger.kernel.org>; Wed, 15 Feb 2006 20:04:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ulJjMBxWDFoepacT3XWBD4iPLtJARFEP02douq+qqi4LOgQi3sLfFG1fbua9T+MR0A299Dinco1/Z/IUzw/pkGGH2fr0U4c39bmK9GURwlj6CDkoYn1NsDeTJslWCnXqycE/Wuzwv8hAlkkelRELzWfO1vaU6C1LdeNyJ3ngu9s=
Received: by 10.54.122.6 with SMTP id u6mr31649wrc;
        Wed, 15 Feb 2006 20:04:10 -0800 (PST)
Received: by 10.54.71.8 with HTTP; Wed, 15 Feb 2006 20:04:10 -0800 (PST)
To: Thomas Riboulet <riboulet@gmail.com>
In-Reply-To: <22e91bb0602151636r2e70e60cpa5038f4b6caccc9c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16269>

On 2/16/06, Thomas Riboulet <riboulet@gmail.com> wrote:

> . Can I import from cvs ?
> Yes. Use git-cvsimport. See the cvs-migration doc for more details.
>
> . Can I import from svn ?
> Yes. Use git-svnimport. See the svn-import doc for more details.

+ Can I import from arch/baz/tla? Use git-archimport.

+ Can I import from others? Maybe -- check if tailor.py can do it.

cheers,


martin
