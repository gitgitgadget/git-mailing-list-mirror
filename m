From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [msysGit] Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 21:49:45 +0000
Message-ID: <57518fd10802071349w50446803q249cbda0e2998bc5@mail.gmail.com>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org>
	 <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de>
	 <20080207123108.GA12009@bit.office.eurotux.com>
	 <alpine.LSU.1.00.0802071255110.8543@racer.site>
	 <20080207130715.GA14000@bit.office.eurotux.com>
	 <alpine.LSU.1.00.0802071324460.8543@racer.site>
	 <7v1w7ooes3.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0802071831520.8543@racer.site>
	 <7vprv8mu2k.fsf@gitster.siamese.dyndns.org>
	 <20080207202357.GO30368@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Luciano Rocha" <luciano@eurotux.com>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 22:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNEdT-0006bg-D1
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 22:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288AbYBGVtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 16:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbYBGVts
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 16:49:48 -0500
Received: from el-out-1112.google.com ([209.85.162.183]:22622 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756868AbYBGVtr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 16:49:47 -0500
Received: by el-out-1112.google.com with SMTP id v27so1456423ele.23
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 13:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=bB+FOwy1Q8yfQy8BjBG8C8MQrFqTJI0ZMSxo3s8qBtU=;
        b=XvPjKQ1v2jkoOrtuLdlkDSPoyzSLLLPraNdA1+E6O9K5FT0QpegG9TYETjV0vKxEEWBNVmb3B7FBhvsSrVjK1s9LOH0Veyacydg73SJ4hi4oQ5HpyPOA6crjivxug3/Ojy464bcNxqWO2A6Z2Z4m2iLtg9jRtNrhdxUKKqoti2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=BIAJCH7T12Gt1xGyBZp/YU37BRttyGfEI200GT+BvUU7HER7rREVtBD/YQRGBqOFc4fIspC1UgUxwbguaW4HWueWluGJ/6Jf+MsLo26pS/SlB7VjkZRaqkh1OT3IpL6p+2Z5h+LZGZBUgLPFko/M9hpDn4/8z6n57yF5MVHjO2o=
Received: by 10.141.123.4 with SMTP id a4mr7936598rvn.172.1202420985640;
        Thu, 07 Feb 2008 13:49:45 -0800 (PST)
Received: by 10.141.86.15 with HTTP; Thu, 7 Feb 2008 13:49:45 -0800 (PST)
In-Reply-To: <20080207202357.GO30368@dpotapov.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 8cd77661a9858d63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73007>

On Feb 7, 2008 8:23 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Thu, Feb 07, 2008 at 11:42:59AM -0800, Junio C Hamano wrote:
> >
> > It does not matter if the person is somebody you know or you
> > have shared with.  I'd grant you that Luciano could have been
> > more diplomatic when he started his message, but I'd agree that
> > it is silly to refuse to install an end user program unless the
> > end user agrees to GPL that governs how its sources can and
> > cannot be used, especially if the installer does not even
> > install the sources to the software.
>
> Actually, the GPL is applied to the binary form too, and it
> prescribes how the program can be redistributed. There is no
> restriction on how the user can run the program, but we still
> must give to the user a copy of GPL in the appropriate way.
> Besides, the user should acknowledge that he or she is warned
> the program is provided "AS IS" without warranty of any kind.
> If the user cannot accept that, he or she should not run the
> program.
>

Just out of curiosity - does this mean that MacPorts (a fink-like
package manager for OS X) ought to display the license while
installing?  Or does that somehow not apply here?
