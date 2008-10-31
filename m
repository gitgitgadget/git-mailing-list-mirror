From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: why not TortoiseGit
Date: Fri, 31 Oct 2008 08:57:31 -0700
Message-ID: <d411cc4a0810310857y5b4f8c46ue33e1f6a9e2c13d1@mail.gmail.com>
References: <7FD1F85C96D70C4A89DA1DF7667EAE96125890@zch01exm23.fsl.freescale.net>
	 <20081031121913.GE18221@sys-0.hiltweb.site> <490AFBA5.5090700@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ian Hilt" <ian.hilt@gmx.com>,
	"Li Frank-B20596" <Frank.Li@freescale.com>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 31 17:00:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvwOc-000334-EJ
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 16:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbYJaP5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 11:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbYJaP5f
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 11:57:35 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:32481 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbYJaP5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 11:57:32 -0400
Received: by wa-out-1112.google.com with SMTP id v27so661814wah.21
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Qs5DIgJxvdaRH450W9mz0k9t2kjn1D6JcAFVrs7ejx0=;
        b=pI9ahjrDqpsaLCNq4ricxzRH7TnR5wMmUf/gNjOiiuFDuGJwFY/q+ZD072X9shZ/VD
         EksKKUxw9lW4TF2k16RDse+ssD6MOcxSE3PccCD8qCqkc9wTK4KJhmcJLz5mIBgiuXjJ
         /0tBr/nRd0+ZlySfuuiynKmZVE4V3pnohw9aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pv/h2RrDMKqgSmyozsZQ19P/qFkJcXoEPL8094Pk1BgDCsS/te2uQyXtoFO7tiEfiE
         gsVX1bA2ka3sG3z4gBYrevigRUhIizbVpQGhMD8ZlCqmpV1viRt6l98f090u5F9uFOPx
         7jg8ViAqATQg0OaWj/CHDgqBj3Ibr+6uk1WiI=
Received: by 10.115.48.12 with SMTP id a12mr10142732wak.38.1225468651982;
        Fri, 31 Oct 2008 08:57:31 -0700 (PDT)
Received: by 10.114.135.18 with HTTP; Fri, 31 Oct 2008 08:57:31 -0700 (PDT)
In-Reply-To: <490AFBA5.5090700@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99597>

I'm trying to get this restarted - dscho and I talked about this at
the GitTogether, and I met some people (from the OpenAFS project that
also happened to be there, oddly) who were interested in working on
this with me.  I think the lack of a linkable library has greatly
hindered the development of projects like this, so that will likely be
part of the development process as well.

Scott

On Fri, Oct 31, 2008 at 5:35 AM, Andreas Ericsson <ae@op5.se> wrote:
> Ian Hilt wrote:
>>
>> On Fri, Oct 31, 2008 at 09:44:45AM +0800, Li Frank-B20596 wrote:
>>>
>>> There are TortoiseCVS, TortoiseSVN, TortoiseBzr, TortoiseHg
>>> Why not ToroiseGit
>>
>> This is what Johannes Schindelin had to say,
>>
>>        <http://code.google.com/p/msysgit/wiki/GitCheetah>
>
> Noone's written TortoiseGit yet. I have no idea why, and I have
> no reason to write it myself. If GitCheetah isn't working well,
> I'm sure patches are welcome.
>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
