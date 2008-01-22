From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 14:06:12 +1300
Message-ID: <46a038f90801211706p1d428509ne2c74a647b40b1c2@mail.gmail.com>
References: <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se>
	 <8F85366A-C990-47B1-BF60-936185B9E438@sb.org>
	 <20080121204614.GG29792@mit.edu>
	 <6E303071-82A4-4D69-AA0C-EC41168B9AFE@sb.org>
	 <20080121211802.GH29792@mit.edu>
	 <45C7CC4A-155F-4FE4-B741-8EE6CF7D3700@sb.org>
	 <46a038f90801211349mfb57c0an9416832c2967c172@mail.gmail.com>
	 <BA2377B5-BE7E-40F2-9C3C-679663A966A4@sb.org>
	 <alpine.LSU.1.00.0801220031490.5731@racer.site>
	 <32CA7B5D-FED0-4C70-A7DE-14E24B74FD1F@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:07:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH7bN-0001vp-Eo
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 02:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643AbYAVBGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 20:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755269AbYAVBGS
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 20:06:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:58234 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756980AbYAVBGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 20:06:17 -0500
Received: by ug-out-1314.google.com with SMTP id z38so986473ugc.16
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 17:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HiJob575StrDKS047dRmB1NzOKh23gsTsFSRHqAOzyE=;
        b=r/YVS5OIpigSRdzUHuJHbr30YXN9rpKWzt/5L1Yi0XcKMqOB+brr0Sex053GzOsLIOPhuCBHmek1XrxrrUYGrSwmPJo49yaMh/Hq1D8U5J/XdA/3BzGpxpDG5X9ayMF5847AvDjf23n1/N6zD+TSS2ehtlAILka6m+3QDTLkuwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JHG3ZkF1VcgDVEL6ldxOL9pHUZFdqedtuY5QhK8eXKIStNtI2IIvQ4niqUPw3SdKzHvyVCZQ6rRR2KKijhZMQ16CwBY2WKLzQWowTaJMeCdV7iBvdx/F0FAhLnQP16H4SJs+FvhDzdGDR7GRd+bSkEzcYy4UxkvvBMAfXKMnLqQ=
Received: by 10.67.98.15 with SMTP id a15mr4955611ugm.69.1200963972263;
        Mon, 21 Jan 2008 17:06:12 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Mon, 21 Jan 2008 17:06:12 -0800 (PST)
In-Reply-To: <32CA7B5D-FED0-4C70-A7DE-14E24B74FD1F@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71391>

On Jan 22, 2008 1:42 PM, Kevin Ballard <kevin@sb.org> wrote:
> And so has EVERYONE ELSE. You cannot hold me to a standard which you
> yourself do not apply.

Hi Kevin,

not sure if you are just joking, but perhaps you have not noticed that
in technical lists like these, you get karma to voice strong opinions
once you've contributed lots of good code. *That* is the standard -
and Johannes has earned his karma points, as Ted and Linus have, by
learning the slow way and writing tons of code. Alas, you don't seem
to have time for such a thing!

Strong opinions without working code tend to not get much respect. So
that is the standard that is applied to all of us, including you.

cheers,


martin
