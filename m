From: Tim Visher <tim.visher@gmail.com>
Subject: Re: `./configure --XXdir=` ignored?
Date: Thu, 26 Feb 2009 10:09:57 -0500
Message-ID: <c115fd3c0902260709i21efa98am1e8b55462e1a5d66@mail.gmail.com>
References: <c115fd3c0902260648g3cc9bfeap58823e53a9dc72e6@mail.gmail.com>
	 <20090226150013.GA9785@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 16:12:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lchtb-00046g-Fn
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 16:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbZBZPKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 10:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbZBZPKA
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 10:10:00 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:59506 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbZBZPKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 10:10:00 -0500
Received: by yx-out-2324.google.com with SMTP id 8so444992yxm.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+uF2uHC+nUbRQ22cWZwjBV5DIwpEN7j/5BejSD5+A9M=;
        b=SnSu3L6WAK1lVFJQmwniRGLek2s750b+DoVne2aMJYR1QBW+s7A2nlev9s/PDu1PmA
         +wTp85S7gu9eJuyn24A4FUcR5Zq/LhnLy1GJzFN6w6ITnMNuA2LkBlHEIy/JW0c+p1Y1
         IT6U6Ws+JMY7pngjgD9xoGocRo0cvZ2sFMMNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ikMyhCHgsiOARpEIzL2OM/76godrxBxxtGYPq8YYuRvWe8sIyXcQhInrILcM0390a9
         i6wNLSBYjTmYEa0qpyc67WcCJSg8xwUVukZJ8OOYDZ1py9+ey2YTqK3TE6W0agIq7tOx
         ZIqVyx0NpR8E6VYPSCWKp0H23R54zWvh4ylfM=
Received: by 10.100.142.19 with SMTP id p19mr1610334and.3.1235660998066; Thu, 
	26 Feb 2009 07:09:58 -0800 (PST)
In-Reply-To: <20090226150013.GA9785@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111571>

On Thu, Feb 26, 2009 at 10:00 AM, Jeff King <peff@peff.net> wrote:

> The configure support is notoriously incomplete

Would it be easier for me to just build the documentation and then
install it by hand then?  Is that even possible?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
