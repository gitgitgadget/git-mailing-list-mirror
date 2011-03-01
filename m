From: Chad Joan <chadjoan@gmail.com>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Mon, 28 Feb 2011 20:45:17 -0500
Message-ID: <AANLkTi=jCtR1NHs8ji0GmdXJXjZ+xPQ6-k1w-jRNtZX4@mail.gmail.com>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 02:45:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuEek-0002KC-Uy
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 02:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973Ab1CABpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 20:45:38 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40520 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab1CABpi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 20:45:38 -0500
Received: by vws12 with SMTP id 12so3732651vws.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 17:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=F9Zm5UjLPdlyrU/nU/a/gCW21j4Dfd9plLdRgt85Z2g=;
        b=RG3Cl3QoIKzCa8ARU11bM9SQSkCz/UmZeYwenxo32+NpTWivKNv8Cem3CBMTho/9Vg
         aJgMEpwirplCWVyJYOwWQI6usO9ZvTk4WrHG43hitwQtCpyeVkSDyBZxOWl0dXEepj/p
         jY2B8nPLYiU75DkXoZSjdCj59+zvkNXqJ8zTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=taxurHnXAVWzzNV11nwvE4YJkMXZtRbfcYnUfRfPSrLxtphbeVOKwXn4gcF1TYUA+Z
         DoFmNfQ1yPVwAIgREb1HRxrJiOq6SjfqPH/xY4EiGdGMarwSQ4XeidjSG+mcQRrNN/WO
         IVWTHuZxbB6jKmsZqhlEU2J/T2ZuRXXnaXTSc=
Received: by 10.52.68.65 with SMTP id u1mr3351399vdt.176.1298943937274; Mon,
 28 Feb 2011 17:45:37 -0800 (PST)
Received: by 10.220.94.136 with HTTP; Mon, 28 Feb 2011 17:45:17 -0800 (PST)
In-Reply-To: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168180>

I should probably also mention that my git version is 1.7.3.4-r1
