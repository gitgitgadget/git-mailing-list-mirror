From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git config: improve documentation
Date: Fri, 1 May 2009 12:09:49 +0300
Message-ID: <94a0d4530905010209n38c23296w324ac9f0cd1e8e87@mail.gmail.com>
References: <1235512745-26814-1-git-send-email-felipe.contreras@gmail.com>
	 <1235512745-26814-2-git-send-email-felipe.contreras@gmail.com>
	 <1235512745-26814-3-git-send-email-felipe.contreras@gmail.com>
	 <7vab8baqp8.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902252052230.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 01 11:10:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzokl-0004fh-D8
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 11:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbZEAJJw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2009 05:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756548AbZEAJJv
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 05:09:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:39228 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbZEAJJu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2009 05:09:50 -0400
Received: by fg-out-1718.google.com with SMTP id 16so716791fgg.17
        for <git@vger.kernel.org>; Fri, 01 May 2009 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hKU9aRi6A1XvF41zx5ANwDJl5shaz/7EMWh4JRW9gHY=;
        b=fcP7lXcZND7k9hqVWHiewZmLavauWZ4AiHNdTDW/0kl0vhIlpj2KZaSVq/00lFZV0V
         j+fHBvs9FclGGluPB3pvkOkm3gC1UFSORJjGE2gC+dU3EXXOMk+ebSGCRpJ8MbPqW1jW
         lmtZSIz86UEjC4vWE1iT8pEjmZYcWPo1hxUns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IJ9k5II4ny07D7yHnCxWv5ds/27y4WOgpDtdV/keGBmRytfY9R+E6qzlCfCm0o0Ybk
         qWa5GDtu3ctP5PWoe/EPElNxMSYKTV3ixayu/Ew33kND5FlBwqcJsbcnRcw3FDj8mgVS
         RXuvSh4CFYMPGv5yNyQGin5aiZyZ7f46fvxv0=
Received: by 10.86.92.9 with SMTP id p9mr2679240fgb.15.1241168989716; Fri, 01 
	May 2009 02:09:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0902252052230.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118067>

On Wed, Feb 25, 2009 at 10:52 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 25 Feb 2009, Junio C Hamano wrote:
>
>> Dscho, can I borrow your sanity?
>
> Nope. =C2=A0I have to rebuild it first.

Shall I send this patch again?

--=20
=46elipe Contreras
