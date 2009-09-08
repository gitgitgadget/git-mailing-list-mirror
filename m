From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: Re: [PATCH resend] git-pull: fix fetch-options.txt to not document
  --quiet and --verbose twice in git-pull.txt
Date: Tue, 8 Sep 2009 09:07:23 +0200
Message-ID: <20090908090723.700fabb6@eleanor>
References: <9f50533b0909070534q2375a793mf5d676b519eae69@mail.gmail.com>
	<vpqd462kl4p.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 08 09:13:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkute-0005JP-1d
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 09:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbZIHHNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 03:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753837AbZIHHNg
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 03:13:36 -0400
Received: from mail-bw0-f175.google.com ([209.85.218.175]:59066 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbZIHHNf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 03:13:35 -0400
Received: by bwz23 with SMTP id 23so581910bwz.13
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=3ZBobxCsop1zoraaewFOTSUvk3FKD/pdTe4rx4fIA+g=;
        b=tak8H8mBkJmoNxqQmeJO9sopwUhM7PflStyHNx7EaK2aE86ictNKy1O/YDQ0Y1R4xZ
         u6vezpJ5Zlf5d50sdYehpdIUSn1coTqecpjizEnaZdb/ShLK2kzAHhACo1D+i8pegwJx
         FxwIE5HCF/y3r9YBMpawADwKqFQMDY86r8SzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=UC9j7ANI1tkok6pwFRqGzZ0weYKJZFOOVMEopGmWus0e6EtgXZyGvHg+y4L4HqxrFi
         kZ3g0nsaKs+6tBFfacuHM4NnWhWSwG21WSOKnTaFTa1IiMXyDZGSBp++3Px3G8LkG7dI
         F4SZR+dVxQTnj6XwUbiIQk1iqcMxRFUCMSUos=
Received: by 10.103.85.12 with SMTP id n12mr6548976mul.29.1252394016828;
        Tue, 08 Sep 2009 00:13:36 -0700 (PDT)
Received: from eleanor (cxr69-1-87-88-216-137.dsl.club-internet.fr [87.88.216.137])
        by mx.google.com with ESMTPS id j9sm1070515mue.38.2009.09.08.00.13.36
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Sep 2009 00:13:36 -0700 (PDT)
In-Reply-To: <vpqd462kl4p.fsf@bauges.imag.fr>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127981>

Thank you for your patience. 
Because I want to be kind to our maintainer :-), I've just finish a
complete reading of SubmitingPatches. Next time I promise : no more
whistespace mess and a commit message were it is meant to be.

Best regards

Emmanuel Trillaud
