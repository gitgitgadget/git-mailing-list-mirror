From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 00/40] MinGW port
Date: Thu, 28 Feb 2008 10:38:50 +0700
Message-ID: <fcaeb9bf0802271938n2eeb63f3h3787a0a20f739031@mail.gmail.com>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
	 <47C5DDC0.8060004@trolltech.com>
	 <46a038f90802271534p37869c58oe79b959b4919c603@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <marius@trolltech.com>,
	"Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 04:39:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUZcF-00077R-N6
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 04:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480AbYB1Diw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 22:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755435AbYB1Diw
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 22:38:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:8301 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbYB1Div (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 22:38:51 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2522166fga.17
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 19:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=i+++V2ti52iO+Q4Jml3b9inm+nc2BCyAu4hO5m+/7mU=;
        b=CtVUPCiy4g3Ed1gHkH9utiQCXIvtTE4fTT6zpfsxFHU2bBwbOMq6Fquz00OqzjKIdlyv75BOMETAHAbm8J8VuJdfJV1hrCb3GlPaMWsRV4hajpW07mqaJC5ViC8FsmsLiqXbcJ6GfZkSkApisT43D2Ivdv9jzPef0Z7/FFfZGvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dZSyGMZKwqK54dm0xvkNT1AoBj27tUjtjwNROjX/f6IXzmTojgONKTJix0Cqd9XvHC7dAu/HMYwJqFI5DwSO+wu53lxAhaSgn05h3y0BwKPvDHj4GLBPnGXJRcriFHnkQvVD4agAVMx7bQ3fl0xKEifbJl14n1VSCCNbGn/gvNM=
Received: by 10.86.72.15 with SMTP id u15mr7238921fga.21.1204169930130;
        Wed, 27 Feb 2008 19:38:50 -0800 (PST)
Received: by 10.86.83.3 with HTTP; Wed, 27 Feb 2008 19:38:50 -0800 (PST)
In-Reply-To: <46a038f90802271534p37869c58oe79b959b4919c603@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75347>

On Thu, Feb 28, 2008 at 6:34 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Thu, Feb 28, 2008 at 11:01 AM, Marius Storm-Olsen
>  <marius@trolltech.com> wrote:
>  >  I just have to say, MASSIVE work Hannes! Thank you so much for your
>  >  efforts in making the MinGW port the great port that it is!
>  >
>  >  You too Dscho, and the rest of the MSys Git team! ;-)
>
>  Indeed. Amazing stuff. I do some occasional work on Windows, and it is
>  a sheer pleasure to use msys git. Simple install, it just works, and
>  it is fast fast FAST. Hats off!

Yeah. I've been waiting this moment for too long. Thanks all.
-- 
Duy
