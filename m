From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 03:10:59 -0600
Message-ID: <20120202091059.GE3823@burratino>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <1328145320-14071-2-git-send-email-felipe.contreras@gmail.com>
 <20120202081622.GB3823@burratino>
 <CAMP44s3FxUmnpQevoV2ARJpWK9CJ16zXDmpJRDOLHNW6RdSc5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 10:11:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsshY-0004ZF-6R
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 10:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab2BBJLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 04:11:21 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38758 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab2BBJLS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 04:11:18 -0500
Received: by iacb35 with SMTP id b35so2861442iac.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 01:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MzlThTuRp72oo8o0aCsiKYqQMJSokS65i1VlBYkIMi0=;
        b=UJLctGz+g5fc8Nb74s52IVAqk/nHRd+6n7YJtxwXFwTPDB0jKYt239YYDYd6A1MO7C
         J1t37f2NJcMJJ4DGjWoFejLimr3Txu1Ux7KMZdqPLK95khsNVfej7I+Rm+C2mFBSpcaD
         ++U7DOdoVyh+CqvIADjZITkUUmaarXX7sYU7g=
Received: by 10.42.150.200 with SMTP id b8mr1736466icw.43.1328173876311;
        Thu, 02 Feb 2012 01:11:16 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ko6sm18800107igc.2.2012.02.02.01.11.15
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 01:11:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s3FxUmnpQevoV2ARJpWK9CJ16zXDmpJRDOLHNW6RdSc5Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189607>

(dropping Shawn from cc list, since I don't think he's touched the
 completion code for years)
=46elipe Contreras wrote:
> On Thu, Feb 2, 2012 at 10:16 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> Patches didn't hit the list again. =C2=A0Any idea why?
>
> No. A bug in list software?
>
> I didn't get any warning or error.

Except in response to HTML attachments, I've never seen vger return any
explanation when it decides a message is spam.  It just discards them.

See [1] for details.  If there's no obvious explanation, I'd suggest
contacting the postmaster.

Hope that helps, and sorry for the fuss,
Jonathan

[1] http://vger.kernel.org/majordomo-info.html
