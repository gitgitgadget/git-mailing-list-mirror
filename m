From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: parsecvs repository moved...
Date: Mon, 16 Apr 2007 20:55:12 +1200
Message-ID: <46a038f90704160155x12072530k6436512922f4c8c1@mail.gmail.com>
References: <46a038f90704160032m9cfee8ai9830c81dd4a64cd6@mail.gmail.com>
	 <20070416075829.GK2689@curie-int.orbis-terrarum.net>
	 <46a038f90704160139o4a474876qfd5b3a6e21df279f@mail.gmail.com>
	 <20070416084238.GL2689@curie-int.orbis-terrarum.net>
	 <46a038f90704160151q2121086bx1b224804d93ba481@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Robin H. Johnson" <robbat2@gentoo.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 10:55:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdMzW-0007I0-NC
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbXDPIzO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbXDPIzO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:55:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:19122 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030224AbXDPIzM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 04:55:12 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1536866wxd
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 01:55:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TLI6ZeREPkQoqkMOI/O9R8brLaEfEA8GdWv65KBkElvFhRKtGpFQKBQs4x46JAtaxhu8OOB/oT/ggleXzbnsP57N925Q+9WrfIKf652HExMHhrSfuqc9kV5GZmPt6gyRN3IjazgLUMwRc+ExlKl0WT2BGBrNMi5iPCkO9lPqwDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lIYA5IinT33jP0I7wM2eeOWaVzxrqUNOrJSSX/0fe5f2jd0ihb+7gLja0mppUnS0u+yiOa5rK0Td3ljNgsflKwTDrRZsNqUB/xnYCUGeoMgEmMm3dpEoxUcf5+0CiU5jSL7tBVHPaYcLqp/J3OzCcAyWe2yAQNAfBOqtRrHFGnI=
Received: by 10.90.115.4 with SMTP id n4mr794706agc.1176713712289;
        Mon, 16 Apr 2007 01:55:12 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Mon, 16 Apr 2007 01:55:12 -0700 (PDT)
In-Reply-To: <46a038f90704160151q2121086bx1b224804d93ba481@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44632>

On 4/16/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> If you'd rather not receive duplicates, you can probably filter out
> for duplicates in by message-id at your MUA/procmail.

Actually - it's not a "probably" but a fact of life - look for
'duplicate' in the procmail quick-start guide:

     http://www.ii.com/internet/robots/procmail/qs/

And a quick google tells me there are similar recipes for Exim and a
few other mail-related tools.

cheers,



martin
