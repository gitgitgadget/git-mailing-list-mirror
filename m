From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 07:13:25 -0600
Message-ID: <b4087cc51003190613y2fe32c26jd27cb009e64f197c@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com> 
	<b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com> 
	<46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com> 
	<b4087cc51003181457s76560b02y84aafbe77f45af87@mail.gmail.com> 
	<4BA36F5F.9080706@gnu.org> <b4087cc51003190543mafc403q6260a3774653e2d5@mail.gmail.com> 
	<4BA373C0.2070506@gnu.org> <b4087cc51003190603v259b833embb40b7360a07cf1f@mail.gmail.com> 
	<4BA3776B.5040706@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 14:14:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsc1Q-00043L-5f
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 14:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336Ab0CSNNr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 09:13:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:23045 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab0CSNNq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 09:13:46 -0400
Received: by fg-out-1718.google.com with SMTP id l26so188129fgb.1
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=m6ebHX57JRE20TFIF4cuLSaFmYwCxviUzzupj0OqYvU=;
        b=JXvq80Uh5lqGQhyd+IX2ggkJB2W0hBYmUQVFH5nKTbbzsQvj3OF+7PHhUDbTB/a/ts
         KBNWaZhKN+pUssdlFT4xPp1EQODDOyIrIgAvJMMYNYlN20qyhqeha4RSGOxSfCtSwHvk
         mv7XGYerT/+xSbq2cgRfKa1umWmKh5hXRzZJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gvzYKRSObGiz6BLwKDA7IdfOADqInEfWRUyE/SgQ6WWBxos5cJo0am8s6oxNfHIbA5
         DpI9qH7SFLjESg3tJGmIwVmPHurJivgL+bRyU4BxB/aWFHG3vrEz+gDLMmfaKAYyYWyR
         NHHU/eBABpifgfO4SnIIygL/k+AhBkSKRMhaE=
Received: by 10.239.187.206 with SMTP id m14mr1555973hbh.49.1269004425280; 
	Fri, 19 Mar 2010 06:13:45 -0700 (PDT)
In-Reply-To: <4BA3776B.5040706@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142590>

On Fri, Mar 19, 2010 at 07:08, Paolo Bonzini <bonzini@gnu.org> wrote:
> Maybe you have to define entropy. =C2=A0For human consumers, "Paolo B=
onzini
> <pbonzini@redhat.com>" has considerably less "entropy" than
> 8aacc35ffca0d34fccf8a750e84e3a81bdcb940b, as does even "Paolo Bonzini
> <bonzini@gnu.org, pbonzini@redhat.com>". =C2=A0For non-human consumer=
s, a good
> mailmap will do.

As I've stated before many times, the SHA-1 is not necessary to the pro=
posal.

Please go read.
