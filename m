From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v6 2/2] mergetools: add winmerge as a builtin tool
Date: Fri, 22 May 2015 13:16:07 -0700
Message-ID: <20150522201606.GB26066@gmail.com>
References: <1432112843-973-1-git-send-email-davvid@gmail.com>
 <1432112843-973-2-git-send-email-davvid@gmail.com>
 <20150520130929.Horde.vYwOuIDRpi6hr15rOUbW1w7@webmail.informatik.kit.edu>
 <20150522195802.GA26066@gmail.com>
 <xmqqr3q8e5tj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 22:16:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvtMf-0003pC-7a
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 22:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757630AbbEVUQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 May 2015 16:16:13 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:32946 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757044AbbEVUQM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 16:16:12 -0400
Received: by pdbqa5 with SMTP id qa5so27512256pdb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I716M5D6dGIdNTpmqS6mRSMdxUj3Zwj6+TBY+CGAyp8=;
        b=xsF9Ytqb7NKeJLu+8O/eZtGPFoh7zhqZLIaTefPNuK8OIs13hXvTiPVz7XWFim9T2V
         Du5lT1IjdBFFWOPdjGmsA93WDuErGeJEo51KtvPH1pw5cf3FDTwqgJqSJs/dyW7F+LWW
         jjOVQnProB3APrrBo0UNv61I9g++AcJ7odSiSFGItGMQIIX9aMzOI8UxOiIBYjb1FuhE
         Vd0lLgHqGIIV2OUr39gAcCbKxKXrhWgdCDPhnDrGv90/TVcgDleOOnUzipWoZ+kcEjBL
         WFeYSIRxKmBxSh5p8JHmBihx2y+Nkp4quHe3j9xZNYT7jdg5aF8H3d4Rw70OXxTBUFQt
         3Uug==
X-Received: by 10.68.241.9 with SMTP id we9mr18376395pbc.59.1432325772146;
        Fri, 22 May 2015 13:16:12 -0700 (PDT)
Received: from gmail.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPSA id ml6sm2931853pdb.69.2015.05.22.13.16.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 13:16:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqr3q8e5tj.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269759>

On Fri, May 22, 2015 at 01:05:28PM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
>=20
> > [just wrapping up the unaswered questions in this thread]
> > ...
> > On Wed, May 20, 2015 at 01:09:29PM +0200, SZEDER G=C3=A1bor wrote:
>=20
> Thanks for clarifications.  I think all is good now?

Yes, I think so.  I just looked at what you have queued in pu
and it looks good.

Thanks all,
--=20
David
