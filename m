From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] rebase -i -p: document shortcomings
Date: Tue, 1 Jun 2010 13:40:38 +0200
Message-ID: <AANLkTimy22yhbxDEfcIg5nPxguWslCIrIEk6wH9kzZqg@mail.gmail.com>
References: <20100601014335.GA21970@progeny.tock> <AANLkTimjcHpbbpfwNoZGq3_1TjfLAzJL3C8Jcp6LeyW0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Florian Weimer <fw@deneb.enyo.de>,
	=?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg@alea.gnuu.de>
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 13:41:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJPqF-0001bH-CP
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 13:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab0FALlA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 07:41:00 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:53188 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab0FALk7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 07:40:59 -0400
Received: by ywh9 with SMTP id 9so3430424ywh.17
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=akaswQ3P25jbFjeqGyN5oepTuDSyosrlNQ83Z1SH3z8=;
        b=nWBMaAspkHVV9FJXHLIhDLQwj3Ln7bTZrC/aJ1nDIDYhBkayMVRTALxEI3ZRcYf/OW
         tRAkL8X1n2c1E6m2Kb6piyL6GH/bF6J7dJf4XNNef8Oa/oN+bpFYGle2oubA8pQHr8F/
         yO3edWuF6C9CBANrBxXNmdq4csvompuF5GEgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TEy2MGXhWyRUa4/TQQJ7xOmfd+5yvny65cauxiHfzo3T7aqFvmfyF/fKH5ovNpsbVx
         LeEoQrs9newJo57ldpAicfWEgYEu9ne3fsEcFlF0suBYs3iGebNWH5gU8yPz3yUc9xRE
         cGmq34i9JS7RQ4RswlS+7ISBKsJdBVAMi/QtY=
Received: by 10.150.235.4 with SMTP id i4mr6101411ybh.356.1275392458659; Tue, 
	01 Jun 2010 04:40:58 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Tue, 1 Jun 2010 04:40:38 -0700 (PDT)
In-Reply-To: <AANLkTimjcHpbbpfwNoZGq3_1TjfLAzJL3C8Jcp6LeyW0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148109>

Heya,

On Tue, Jun 1, 2010 at 04:22, Greg Price <price@ksplice.com> wrote:
> Thanks, this is long needed. =C2=A0I regret that I haven't had time i=
n
> several months to continue work on the real fix.

Is it your or Jonathan's intent on finishing Dscho's work on rebase -i =
-p?

--=20
Cheers,

Sverre Rabbelier
