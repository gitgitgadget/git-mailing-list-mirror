From: John Tapsell <johnflux@gmail.com>
Subject: Cross-Platform Version Control
Date: Wed, 13 May 2009 13:41:54 +0300
Message-ID: <43d8ce650905130341g516c899fsdc6b50a45381d4c6@mail.gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
	 <20090512151403.GS30527@spearce.org>
	 <alpine.DEB.1.00.0905121808480.4447@intel-tinevez-2-302>
	 <D1E08DA2-8D8E-4D45-A50A-F32E3448D6E9@gmail.com>
	 <alpine.DEB.1.00.0905122237230.27348@pacific.mpi-cbg.de>
	 <4A09E719.4090205@gmail.com>
	 <alpine.DEB.1.00.0905130222460.27348@pacific.mpi-cbg.de>
	 <4A0A5BDB.9030602@gmail.com>
	 <alpine.DEB.1.00.0905131215010.5046@intel-tinevez-2-302>
	 <43d8ce650905130340q596043d5g45b342b62fe20e8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 12:42:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4BuW-0007dD-W8
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 12:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbZEMKlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 06:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755382AbZEMKly
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 06:41:54 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:62271 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbZEMKly convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 06:41:54 -0400
Received: by gxk10 with SMTP id 10so1006501gxk.13
        for <git@vger.kernel.org>; Wed, 13 May 2009 03:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ubJzPxQM5Sc74fv7VUrtIx9d7jU575UN18YZLahO2AY=;
        b=gC0BBVrK6wWrlwkVGw97C+KeVfekeYsWXV0kDS5oP5P3XJZD4edD0Jvb5rA42ltIXd
         1+09qZSkU+ILVhej0FhoUtcdrNJbQvcRkG+Ck1m9mw8AThcWDikpMDJ0ZGG9KQcHFST+
         ErqpFeVBlKjqshnu4/s3RdEtj4gqOBimKtcYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=U77u55+QMWXbL/cLF3i70uqfT6qlO/yGyD+ec2owaKz0Ak/5b5gSXzlDRose5KdQ6B
         deZ/a6oYHEhf/TXugmZuwsoVWWwbC57DAkXwCST2klSMN9BV3KzpfebXfqcKYs0fdmDN
         SMm42/MW/P/f5EhFKRDOmHwravU8/ateOCF7U=
Received: by 10.151.75.6 with SMTP id c6mr891460ybl.242.1242211314578; Wed, 13 
	May 2009 03:41:54 -0700 (PDT)
In-Reply-To: <43d8ce650905130340q596043d5g45b342b62fe20e8d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119031>

2009/5/13 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Wed, 13 May 2009, Esko Luontola wrote:
>
>> Johannes Schindelin wrote on 13.5.2009 3:23:
>> > Well, that rather settles things, no?
>>
>> There is need for the feature, but it's unfortunate that the Git
>> developers do not see its value.
>
> I see a value. =C2=A0But it is not my itch. =C2=A0And since it is you=
r itch and you
> said that you will not do anything about it (I don't count writing em=
ails
> here ;-), I concluded that it settles the issue.

I don't know why the git developers are being so hostile/dismisisve,
but I also hope that somebody volunteers to fix this.
Esko, you have my moral support :-)

John
