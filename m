From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFH] Questions for Git User's Survey 2009
Date: Wed, 10 Jun 2009 20:55:28 +0200
Message-ID: <fabb9a1e0906101155y330e9088h1a57a738593636b8@mail.gmail.com>
References: <200905291855.03328.jnareb@gmail.com> <200906102042.15119.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 20:55:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MESxp-00031f-Lh
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 20:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628AbZFJSzs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 14:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbZFJSzr
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 14:55:47 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:52877 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbZFJSzr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 14:55:47 -0400
Received: by ewy6 with SMTP id 6so1269349ewy.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 11:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mkD6x4V39uh3pF+3A96ZAxena7hQZwYX7KdAoUvMWLg=;
        b=mioXNJvM3E+AQ1hqF1bJHvOD8sHSGphEHUhbFl+TdKmHPPcCfD6cTGyZ02VqkluxbK
         FWA9Pwxpo7npYPIW0K376Is9AVywrYfYmVv1i5KBQ8eTyVJToYBnCTniNbhQYoP4kwdw
         j0Uw+gj97UW0NrvyVEA+HsRnkfcTR9xmv2su8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wolmmynUvyOfAaKyzwURTmLMji0urIXpGsbcYIZ49zYadZ+p5WFP2KloqEj5Z+D/qx
         eZh5KAiuBbtLKEexWmBYaF4qNkl4D7fCxAEzgehct21zQ+wf78cMMVFEFet1yHQ5WQxP
         fKeEkkeoNFL+0MrdvvnjU9n0YvI2Kc/PFFqa8=
Received: by 10.216.9.66 with SMTP id 44mr627719wes.73.1244660148248; Wed, 10 
	Jun 2009 11:55:48 -0700 (PDT)
In-Reply-To: <200906102042.15119.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121293>

Heya,

On Wed, Jun 10, 2009 at 20:42, Jakub Narebski<jnareb@gmail.com> wrote:
> 14. How do you fetch/get changes from upstream? =A0[NEW!]
> 15. How do you publish/propagate your changes?

I think it needs to be made more clear here that you mean in general,
not just changes to git.git (since you had a question about how one
fetches git itself earlier), if that is indeed the intent of this
question.

Other than that, I think it'd good we cut down the amount of (open)
questions :).

--=20
Cheers,

Sverre Rabbelier
