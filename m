From: "David Aguilar" <davvid@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary
Date: Wed, 3 Sep 2008 19:43:20 -0700
Message-ID: <402731c90809031943n181ad6fbw366f90e80aaca2a@mail.gmail.com>
References: <200809031607.19722.jnareb@gmail.com>
	 <20080903144552.GA27682@spearce.org>
	 <20080903172050.61d510d6@pc09.procura.nl>
	 <94a0d4530809030925t33d4260bof169372d65717af4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 04:44:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb4pg-00056l-GB
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 04:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbYIDCnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 22:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbYIDCnW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 22:43:22 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:9122 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbYIDCnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 22:43:21 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3061395wfd.4
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 19:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YrfKoSomEbvusBIzouKQIpiFCf2cU0eWiFfkKyGAOac=;
        b=xSo1hrdxwnMr6lCU8h+WPMKWgrXPr8M0FHeziS8+wkEozD+nRnDY/adBzczH/GIrHU
         XpXcFKe6COBd4Njghuo2djFjqfEswu9AXi29YRDeOsoJ2myseuYvxkgYiMwRvLlF4XN4
         KppfWwswn9M5QD8VUL4XbyY2p+4U+MZcaIvMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OiNN1kNbBh7PthBDyycw2aQivnCjThmFJZ/2FF8EPpv/Agl6GN36Ej7O0CILh5b25A
         FRY1srklEagjlFlpaBrMlrYpoJHZYpxdQ+IS0Vz+dcFNPV9u/4LOlRcZ5lI2Pz/EC/Ef
         OIIthvSC7RpicrFGC2lkzOagR4j+GIFXX5uSA=
Received: by 10.142.191.2 with SMTP id o2mr3327775wff.221.1220496200475;
        Wed, 03 Sep 2008 19:43:20 -0700 (PDT)
Received: by 10.142.174.2 with HTTP; Wed, 3 Sep 2008 19:43:20 -0700 (PDT)
In-Reply-To: <94a0d4530809030925t33d4260bof169372d65717af4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94881>

On Wed, Sep 3, 2008 at 9:25 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Sep 3, 2008 at 6:20 PM, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
>> On Wed, 3 Sep 2008 07:45:52 -0700, "Shawn O. Pearce"
>> <spearce@spearce.org> wrote:
>>
>>> Jakub Narebski <jnareb@gmail.com> wrote:
>>> > This is partial summary of Git User's Survey 2008 [...]
>>> >
>>> > 03. With which programming languages are you proficient?
>>> >
>>> > Around 939 people answered this question.  C is most popular with 59%;
>>> > Ruby and surprisingly a bit shell script programming have around second
>>> > place, with about 52-53%.  More people are proficient with Python than
>>> > in Perl by about 1/3-1/4.  Very few people (25 responses, around 3%)
>>> > feel proficient in Tcl/Tk, which means shallow pool of possible git-gui
>>> > and gitk contributors.
>>
>> Rewrite them in perl or python and get more patches?
>> The fact that it is not perl withheld me from finding solutions to
>> problems I still have with the git-gui gitk combination
>
> Ruby!
>
> --
> Felipe Contreras

There's already a python git-gui:
    http://cola.tuxfamily.org/

PyQt is a very mature library, which is one of the primary reasons I
chose Python.
Does Ruby have any good and mature UI libraries?  I know it's all the
rage for web stuff, but I haven't heard too much about people using it
for GUIs.

-- 
 David
