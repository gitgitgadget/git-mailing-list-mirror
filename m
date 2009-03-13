From: John Tapsell <johnflux@gmail.com>
Subject: Re: Not pushing all branches?
Date: Fri, 13 Mar 2009 13:56:10 +0000
Message-ID: <43d8ce650903130656p73e1e149s702f70466bbdb182@mail.gmail.com>
References: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se>
	 <43d8ce650903130125m6335d189obbcdb86ec9036083@mail.gmail.com>
	 <alpine.DEB.1.00.0903131149200.10279@pacific.mpi-cbg.de>
	 <43d8ce650903130537r2459e1d2pef8fffc1c9b3fa5e@mail.gmail.com>
	 <alpine.DEB.1.00.0903131452390.6288@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 13 14:57:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li7tM-0005Ic-R3
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 14:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbZCMN4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 09:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754366AbZCMN4N
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 09:56:13 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:57994 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129AbZCMN4M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 09:56:12 -0400
Received: by wf-out-1314.google.com with SMTP id 28so451696wfa.4
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sYqi7v7pRQFBGMkF3Htu2Krjp9l1pG1QLyUCYMNUYnY=;
        b=dg8FgG/3yb+bqZ1mR+cucX0amaok3KbzlYy+1r5mUODLz+Gi/MhGsrgxo7b+A5HBiK
         wSujJqzhty+XJ8hisPmS1L6Rfp43056DACE6tXXlZsqu5Z7ySCkfUkrA8PK5QARkIzYp
         foFfZdVIQ6hVGyF0BO4w14Qxwg16l62EPjGEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CcTyUDRgBtGlDdrp4kCt+nVI5OXHYrBcw5TFOX6+SKWuRat77kJeqD+BbuD25LOV+L
         OuwCh2PxkAGlFkHqc30aijRF27bj+WXXBxnp7McyCVDN+CMYJOl26WDJF5GTsFk5sBhx
         We9axIR/9h4mGyS25RIr4o5+LflubE3Ypd8zY=
Received: by 10.142.53.19 with SMTP id b19mr609199wfa.154.1236952570787; Fri, 
	13 Mar 2009 06:56:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903131452390.6288@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113187>

2009/3/13 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Fri, 13 Mar 2009, John Tapsell wrote:
>
>> Hopefully the first 5 will be applied and the 6 will debated, then
>> grudgingly applied :-)
>
> No. =C2=A0If it has to be applied grudgingly, it is most likely wrong=
=2E

If there's an email about this every week from yet another person that
has been bitten by the current default, then the current default is
most likely wrong :-)

John
