From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Anyone running GIT on native Windows
Date: Mon, 7 May 2007 13:48:08 +0200
Message-ID: <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>
	 <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>
	 <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>
	 <463ECEF4.625F3633@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon May 07 13:48:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl1hO-0005IX-Iq
	for gcvg-git@gmane.org; Mon, 07 May 2007 13:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318AbXEGLsK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 07:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933161AbXEGLsK
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 07:48:10 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:20764 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933318AbXEGLsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 07:48:09 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1516963nzf
        for <git@vger.kernel.org>; Mon, 07 May 2007 04:48:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a/1wWiVQzQyfjM6phGOlfCfPqxZcNfdm144pLJWDnInYTlQeMOs12FkDaovGkB5aFGM+dIyykKFNN2Lypdws4uwoAjhjWbk0ALIXX90PBl2Hg6d/5Q6JHng+JZsnEM1hDU2fwSqpVqTrC6svhtRshsh4xFzTqc/8pxdGVfFtv8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jNrhkJRmvFYZMf1H2YFZvtVoHL2S7HzBBtsfpkTx+yAAFDcOjQzYl00P1xB75qt6cQGWMELG+pzd2KvgYVMY/2XMZT6/NTRUwh0CCEe7dLVfQltvADAAmetnMFEoooMUsDLtkxMOkyTklTZp5GrbK6xp+nYTNztTS3ALit0G0/I=
Received: by 10.114.92.2 with SMTP id p2mr1243136wab.1178538488140;
        Mon, 07 May 2007 04:48:08 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Mon, 7 May 2007 04:48:08 -0700 (PDT)
In-Reply-To: <463ECEF4.625F3633@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46451>

On 5/7/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> Aaron Gray wrote:
> > What I want is to be able to work in Windows CMD and envoke .sh scripts by
> > association (unfortunately you have to add the .sh on the command name
> > though).
>
> I run the mingw port exclusively from CMD without a .sh association. So
> exclusively that I don't even know whether any other way of using the
> tools even works. Of course, you have to get used to
>

Is it public available?

I see this as the long term solution to bring git under Windows
(Cygwin is just a temporary shortcut although very useful).

Why to port git under Windows?

Simply, to have better possibility to be chosen by the big projects under Linux!


See Mozilla-Firefox, as example, but not only, some of the biggest
projects under Linux are already ported or are being ported under
Windows (Apache, MySQL, OpenOffice, etc..) and in the future KDE.


Adopting a SCM that has a native porting under Windows is more and
more a sensible choice for the Linux big players.


The problem is that you don't chose an SCM each week, so when the
choice is made you have to wait years to have another opportunity (see
again Mozilla-Firefox thread on this subject), so not only git native
on Windows is the way to go, but also possibly quickly.


  Marco
