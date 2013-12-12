From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 13:53:27 -0500
Message-ID: <CACPiFCLxC-WkiiwXwLTv4s-1GtbX7GrNVGs94Z10Nz+LW8YCEQ@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <20131212181513.GA16960@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 19:53:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrBOT-0008GZ-D6
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 19:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012Ab3LLSxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 13:53:49 -0500
Received: from mail-vc0-f180.google.com ([209.85.220.180]:33827 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab3LLSxs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 13:53:48 -0500
Received: by mail-vc0-f180.google.com with SMTP id if17so578496vcb.25
        for <git@vger.kernel.org>; Thu, 12 Dec 2013 10:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sLXmrHmAvrqXFOfh2hiROm/EjN6ld6nFqc/KF2Ir4FE=;
        b=NdlcdhI6jK4YA3wKxrlRWO40NArCBUob65aAtum4HYEvlC3Kb3LqeawcWcCUqCao2H
         K8db+432qRGe1XMFuF41C7W7aFVULY00A4mxFldwncg/sL2cHLRr8gARDpTndYlgx9k7
         MQRg3rfR2jNaryRMPCOCXtIGnzndH+6tGqo4yHfmByN8RdwUZei5PiK8eatjKZzFFXTH
         i2Vh+XjnJc4aHqMt1IrVPrDGsYoGdSPlrODUvOdSGPUe3kpDw6zQpejNQn+kHxgd/OoY
         U5GdEv1CGRdCanoMfcUgUrEgVbUV64g3meDgSei0LUzyKdNWB1BSeyZu3/aT0cnciYvk
         UGoA==
X-Received: by 10.220.116.136 with SMTP id m8mr223174vcq.77.1386874427827;
 Thu, 12 Dec 2013 10:53:47 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Thu, 12 Dec 2013 10:53:27 -0800 (PST)
In-Reply-To: <20131212181513.GA16960@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239235>

On Thu, Dec 12, 2013 at 1:15 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> That terminology -- "flying fish" and "dovetail" -- is interesting, and
> I have not heard it before.  It might be woth putting in the Jargon File.
> Can you point me at examples of live usage?

The canonical reference would be
http://cvsbook.red-bean.com/cvsbook.html#Going%20Out%20On%20A%20Limb%20(How%20To%20Work%20With%20Branches%20And%20Survive)

just by being on the internet and widely referenced it has probably
eclipsed in google-juice examples of earlier usage. Karl Fogel may
remember where he got the names from.

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
