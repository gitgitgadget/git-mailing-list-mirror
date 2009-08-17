From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 19:50:43 -0300
Message-ID: <a4c8a6d00908171550t357890f2i6f087b1acf135aff@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
	 <a4c8a6d00908171527m778c12fq30d672d3c75cea77@mail.gmail.com>
	 <alpine.DEB.1.00.0908180036260.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 00:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdB2T-00036X-1G
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 00:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758271AbZHQWun convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 18:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758200AbZHQWun
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 18:50:43 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:37912 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757913AbZHQWun convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 18:50:43 -0400
Received: by ywh3 with SMTP id 3so4623682ywh.22
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pqUL9Nac9mceFk1LPEktHCdALPeQFCWKxnCDP6jPtjo=;
        b=Z4rSSOJZHUKYf+OdNfnVagiKJ3/XgD+PAz5MoIyR2/Y9vqljlbsfetul9WSvjTI7Oe
         KSvLDbBVFKpCYxLkjsiuWjYsn0Su16AxF/t/rnO0jqsW/EZh5AjFsDSSNECvBi2ly7hR
         29U3drNjcbJYEwKGMc3dRwfbhIeh2hizbkWIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HBlVlaDHFn5PSjhGRv36gnMp7S5WKmOGr5xTTbMGdBKSJRttowq9gB8f33AjfUaFPg
         mrCsIzJCHTZP9Ei0P64uJjo5XsoCtaCCcKRkhgzNUfzSS/QSGBu4Cr1VvXrE0512TRJ3
         bOG7KRQS3qbxh7+5VUgq+OY1IV0jHdOAPdfO8=
Received: by 10.101.57.4 with SMTP id j4mr4125696ank.104.1250549444087; Mon, 
	17 Aug 2009 15:50:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908180036260.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126311>

On Mon, Aug 17, 2009 at 7:39 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 17 Aug 2009, Thiago Farina wrote:
>
>> What about the common-cmds.h that is included in builtin-help.c? How=
 it will
>> be generated?
>> I followed the instructions in ReadMe, then I can't compile because =
of this
>> "missing" file.
>
> Thiago, you do not want to top-post in both of the mailing-lists you =
sent
> to. =A0And you certainly do _not_ want to send 200K of unanswered, qu=
oted
> text:
>
I tried to don't do this(top-post), but things goes bad again .
>> On Mon, Aug 17, 2009 at 1:05 PM, Frank Li <lznuaa@gmail.com> wrote:
>>
>> [200K that were not needed for Thiago's question]
>
> Sorry, but I do not feel inclined to respond to your question if you =
do
> not want to adher to netiquette that you must have seen when you firs=
t
> posted to the msysGit mailing list.
>
> Ciao,
> Dscho
>
>
